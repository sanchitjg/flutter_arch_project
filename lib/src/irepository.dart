part of flutter_arch_project;

class _DefaultLocalStorage with LocalStoreBase {}

abstract class IRepository<M extends JGBaseResponseModel> extends BaseRepository {
  final IWebSocket? _ws;

  LocalStoreBase get localStore => _DefaultLocalStorage();

  IRepository({IWebSocket? ws, super.onAuthTokenExpired}) : _ws = ws;

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