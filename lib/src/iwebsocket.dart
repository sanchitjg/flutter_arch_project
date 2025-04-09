part of flutter_arch_project;

/// An interface defining the base functionality for a WebSocket.
/// This interface provides methods for sending messages and retrieving incoming message streams.
abstract interface class IWebSocketBase {
  /// Sends a message through the WebSocket.
  ///
  /// \[msg\] - A map containing the message data to be sent.
  void _sendMessage(Map<String, dynamic> msg);

  /// Retrieves a stream of incoming messages from the WebSocket.
  ///
  /// Returns a stream of maps containing the incoming message data.
  Stream<Map<String, dynamic>> _getIncomingMessageStream();
}

/// An interface extending `IWebSocketBase` to provide public WebSocket functionality.
/// This interface includes methods for sending and receiving messages, with implementations
/// that delegate to the private methods of `IWebSocketBase`.
abstract class IWebSocket implements IWebSocketBase {
  /// Sends a message through the WebSocket.
  ///
  /// \[msg\] - A map containing the message data to be sent.
  void sendMessage(Map<String, dynamic> msg);

  /// Retrieves a stream of incoming messages from the WebSocket.
  ///
  /// Returns a stream of maps containing the incoming message data.
  Stream<Map<String, dynamic>> getIncomingMessageStream();

  /// Retrieves a stream of incoming messages by delegating to `getIncomingMessageStream`.
  ///
  /// Returns a stream of maps containing the incoming message data.
  @override
  Stream<Map<String, dynamic>> _getIncomingMessageStream() {
    return getIncomingMessageStream();
  }

  /// Sends a message by delegating to `sendMessage`.
  ///
  /// \[msg\] - A map containing the message data to be sent.
  @override
  void _sendMessage(Map<String, dynamic> msg) {
    return sendMessage(msg);
  }
}