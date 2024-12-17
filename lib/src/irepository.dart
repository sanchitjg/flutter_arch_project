part of flutter_arch_project;

class _DefaultLocalStorage extends LocalStoreBase {}

abstract class IRepository<M extends JGBaseResponseModel> extends BaseRepository {
  final IWebSocket? _ws;
  final LocalStoreBase? ls;

  LocalStoreBase get localStore => _DefaultLocalStorage();

  IRepository({IWebSocket? ws, IHttp? http, this.ls}) :
        _ws = ws,
        super(onAuthTokenExpired: http?.onAuthTokenExpired);

  Stream<M>? _stream() {
    return _ws
        ?.getIncomingMessageStream()
        .map((m) => mapTypeToResponse[m['type']]?.call(m))
        .where((m) => m is M)
        .cast<M>();
  }

  bool sendMessage(JGBaseRequestModel message) {
    return (_ws?..sendMessage(message.toJson())) != null;
  }

  Map<String, JGBaseResponseModel Function(Map<String, dynamic>)> get mapTypeToResponse;
}