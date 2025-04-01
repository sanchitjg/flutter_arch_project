part of flutter_arch_project;

abstract interface class IWebSocketBase {
  void _sendMessage(Map<String, dynamic> msg);
  Stream<Map<String, dynamic>> _getIncomingMessageStream();
}

abstract class IWebSocket implements IWebSocketBase {

  void sendMessage(Map<String, dynamic> msg);
  Stream<Map<String, dynamic>> getIncomingMessageStream();

  @override
  Stream<Map<String, dynamic>> _getIncomingMessageStream() {
    return getIncomingMessageStream();
  }

  @override
  void _sendMessage(Map<String, dynamic> msg) {
    return sendMessage(msg);
  }

}