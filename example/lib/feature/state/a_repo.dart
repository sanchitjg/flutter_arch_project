import 'dart:async';

import 'package:flutter_arch_project/flutter_arch_project.dart';

import '../../app_local_store/app_local_store.dart';

class AppRepository extends IAppRepository<PongModel> {

  AppRepository({super.ws});

  @override
  final localStore = AppLocalStore();

  @override
  bool getCounters() {
    return sendMessage(PingModel());
  }

  @override
  bool unsubscribeCounters() {
    return sendMessage(PingModel());
  }

  @override
  void setCounter(int count) {
    localStore.saveInt('counter', count);
  }

  @override
  int? getCounter() {
    return localStore.getInt('counter');
  }

  @override
  final mapTypeToResponse = <String, ResponseModel Function(Map<String,dynamic>)>{
    PingModel.responseType: (_) => PongModel.fromJson(),
  };

  @override
  void dispose() {}
}

abstract interface class IAppRepository<R extends ResponseModel> extends IRepository<R> {

  IAppRepository({super.ws});

  bool getCounters();

  bool unsubscribeCounters();

  void setCounter(int counter);

  int? getCounter();
}

class MockSocket implements IWebSocket {

  static final _mockSocketController = StreamController<Map<String, dynamic>>.broadcast();

  void dispose(){
    _mockSocketController.close();
  }

  @override
  void sendMessage(Map<String, dynamic> msg)  => _mockSocketController.add(msg);

  @override
  Stream<Map<String, dynamic>> getIncomingMessageStream() => _mockSocketController.stream
      .map((event) => {'type': PingModel.responseType});
}


final class PingModel extends RequestModel {

  static String get responseType => 'pong';

  PingModel() : super(type: 'ping');
}

final class PongModel extends ResponseModel {

  static String get requestType => 'ping';

  PongModel.fromJson() : super({'type': 'pong'});
}