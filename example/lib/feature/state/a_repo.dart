import 'dart:async';

import 'package:flutter_arch_project/flutter_arch_project.dart';

import '../../app_local_store/app_local_store.dart';

class AppRepository extends IRepository implements IAppRepository {

  AppRepository({super.webSockets});

  @override
  final ILocalStorage localStore = AppLocalStore();

  @override
  Future<List<int>>? getCounters() {
    return socket<MockSocket>()?.stream<PongModel, List<int>>(PingModel(), (event) => <int>[]).first;
  }

  @override
  Stream<List<int>>? subscribeCounters() {
    return socket<MockSocket>()?.stream<PongModel, List<int>>(PingModel(), (event) => <int>[]);
  }

  @override
  Future<bool>? unsubscribeCounters() {
    return socket<MockSocket>()?.stream<PongModel, bool>(PingModel(), (event) => true).first;
  }

  @override
  Future<void> setCounter(int count) {
    return localStore.saveToLocalStorage('counter', count.toString());
  }

  @override
  Future<int?> getCounter() async {
    return int.tryParse(await localStore.getFromLocalStorage('counter') ?? '');
  }
}

abstract class IAppRepository extends IRepository {
  Future<List<int>>? getCounters();
  Stream<List<int>>? subscribeCounters();
  Future<bool>? unsubscribeCounters();

  Future<void> setCounter(int counter);

  Future<int?> getCounter();
}

class MockSocket extends IWebSocket {

  static final _mockSocketController = StreamController<Map<String, dynamic>>.broadcast();

  @override
  final mapTypeToResponse = <String, ResponseModel Function(Map<String,dynamic>)>{
    PingModel.responseType: (_) => PongModel.fromJson(),
  };

  MockSocket() : super(_mockSocketController.add, _mockSocketController.stream
      .map((event) => {'type': PingModel.responseType}));

  void dispose(){
    _mockSocketController.close();
  }
}


final class PingModel extends RequestModel {

  static String get responseType => 'pong';

  PingModel() : super(type: 'ping');
}

final class PongModel extends ResponseModel {

  static String get requestType => 'ping';

  PongModel.fromJson() : super({'type': 'pong'});
}