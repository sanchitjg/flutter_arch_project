part of flutter_arch_project;

abstract class IWebSocket {

  void sendMessage(Map<String, dynamic> msg);
  Stream<Map<String, dynamic>> getIncomingMessageStream();

}