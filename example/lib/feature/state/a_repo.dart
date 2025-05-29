import 'dart:async';

import 'package:flutter_arch_project/flutter_arch_project.dart';

import '../../app_cache_state/app_state.dart';
import '../../app_local_store/app_local_store.dart';

class AppRepository
    extends IAppRepository
    with WebSocketMixin<PongModel> {

  @override
  final IWebSocket ws;

  //final localStore = AppLocalStore();

  AppState appState;

  AppRepository({required this.ws, required this.appState});

  @override
  void getCounters() {
    sendMessage(PingModel());
  }

  @override
  void unsubscribeCounters() {
    sendMessage(PingModel());
  }

  @override
  void setCounter(int count) {
    //localStore.saveInt('counter', count);
  }

  @override
  int? getCounter() {
    //return localStore.getInt('counter');
    return null;
  }

  @override
  final mapTypeToResponse = <String, PongModel Function(Map<String,dynamic>)>{
    PingModel.responseType: (_) => PongModel.fromJson(),
  };

  void dispose() {
  }

  @override
  void cacheCounter(int count) {
    //appState?.setCounter(count);
  }

  @override
  int? getCachedCounter() {
    return 0;
    //return appState?.counter;
  }

  @override
  AppState getAppState() {
    return appState;
  }

}

abstract interface class IAppRepository {

  void getCounters();

  void unsubscribeCounters();

  void setCounter(int count);

  int? getCounter();

  void cacheCounter(int count);

  int? getCachedCounter();

  AppState getAppState();
}

class MockSocket extends IWebSocket {

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


final class PingModel extends JGBaseRequestModel {

  static String get responseType => 'pong';

  PingModel() : super(type: 'ping');

  @override
  List<Object?> get props => [];
}

final class PongModel extends JGBaseResponseModel {

  static String get requestType => 'ping';

  PongModel.fromJson() : super({'type': 'pong'});

  @override
  List<Object?> get props => [];
}