part of '../../../flutter_arch_project.dart';

abstract class IWebSocketMixin<M extends JGBaseResponseModel> {
  Stream<M> get _stream;
}

abstract mixin class WebSocketMixin<M extends JGBaseResponseModel> implements IWebSocketMixin<M> {

  IWebSocketBase get ws;

  void sendMessage(JGBaseRequestModel message) {
    ws._sendMessage(message._toJson());
  }

  Stream<M> get _stream {
    return ws._getIncomingMessageStream()
        .map((m) => mapTypeToResponse[m['type']]?.call(m))
        .where((m) => m is M)
        .cast<M>();
  }

  Map<String, M Function(Map<String, dynamic>)> get mapTypeToResponse;
}