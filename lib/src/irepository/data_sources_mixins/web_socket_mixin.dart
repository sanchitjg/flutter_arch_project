part of '../../../flutter_arch_project.dart';

mixin WebSocketMixin<M extends JGBaseResponseModel> {

  IWebSocket get ws;

  void sendMessage(JGBaseRequestModel message) {
    ws.sendMessage(message.toJson());
  }

  Stream<M> socketStream() {
    return ws.getIncomingMessageStream()
        .map((m) => mapTypeToResponse[m['type']]?.call(m))
        .where((m) => m is M)
        .cast<M>();
  }

  Map<String, M Function(Map<String, dynamic>)> get mapTypeToResponse;
}