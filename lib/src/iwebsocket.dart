import 'dart:async';

import 'models.dart';

abstract class IWebSocket {

  /// Send a message via WebSocket
  final void Function(Map<String, dynamic>) _sendMessage;
  final Stream<Map<String, dynamic>> _webSocketStream;

  IWebSocket(void Function(Map<String, dynamic>) sendMessage, Stream<Map<String, dynamic>> webSocketStream)
    : _sendMessage = sendMessage,
      _webSocketStream = webSocketStream;

  factory IWebSocket.defaultWebSocket(void Function(Map<String, dynamic>) sendMessage, Stream<Map<String, dynamic>> webSocketStream, Map<String, ResponseModel Function(Map<String, dynamic>)> mapTypeToResponse)
    => _DefaultWebSocket(sendMessage, webSocketStream, mapTypeToResponse);

  Stream<S> stream<M extends ResponseModel, S>(RequestModel req, S Function(M event) convert) {
    Future.delayed(Duration.zero, () => _sendMessageModel(req));
    return _webSocketStream.where((m) => m is M).cast<M>().map(convert);
  }

  void _sendMessageModel(RequestModel message) {
    _sendMessage(message.toJson());
  }

  Map<String, ResponseModel Function(Map<String, dynamic>)> get mapTypeToResponse;
}

class _DefaultWebSocket extends IWebSocket {
  @override
  final Map<String, ResponseModel Function(Map<String, dynamic>)> mapTypeToResponse;

  _DefaultWebSocket(void Function(Map<String, dynamic>) sendMessage, Stream<Map<String, dynamic>> webSocketStream, this.mapTypeToResponse)
    : super(sendMessage, webSocketStream);
}