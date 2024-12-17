import 'dart:async';

import 'package:flutter_arch_project/flutter_arch_project.dart';

import '../../app_cache_state/app_state.dart';
import '../../app_local_store/app_local_store.dart';

class AppRepository
    extends IAppRepository
    with WebSocketMixin<PongModel>,
        CacheStateMixin,
        LocalStoreMixin,
        HttpMixin {

  @override
  final IWebSocket ws;

  @override
  final Map<Type, ICacheState<IRepoModel>> caches;

  @override
  final http = MockHttp();

  @override
  final localStore = AppLocalStore();

  AppState? get appState => cache<AppState>();

  AppRepository({required this.ws, Set<ICacheState<IRepoModel>>? caches})
    : caches = caches?.toTypeMap() ?? Set<ICacheState<IRepoModel>>.identity().toTypeMap() {
    mergeStream({socketStream(), cacheStream()});
  }

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
    localStore.saveInt('counter', count);
  }

  @override
  int? getCounter() {
    return localStore.getInt('counter');
  }

  @override
  final mapTypeToResponse = <String, PongModel Function(Map<String,dynamic>)>{
    PingModel.responseType: (_) => PongModel.fromJson(),
  };

  void dispose() {
    http.dispose();
  }

  @override
  void cacheCounter(int count) {
    appState?.setCounter(count);
  }

  @override
  int? getCachedCounter() {
    return appState?.counter;
  }

}

class MockHttp extends BaseRepository {

  MockHttp() : super(onAuthTokenExpired: () async {
    return "";
  });

  @override
  void dispose() {}
}

abstract interface class IAppRepository extends IRepository {

  void getCounters();

  void unsubscribeCounters();

  void setCounter(int count);

  int? getCounter();

  void cacheCounter(int count);

  int? getCachedCounter();
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
}

final class PongModel extends JGBaseResponseModel {

  static String get requestType => 'ping';

  PongModel.fromJson() : super({'type': 'pong'});
}