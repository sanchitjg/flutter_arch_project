part of '../../../flutter_arch_project.dart';

/// An interface defining the WebSocket mixin functionality.
///
/// This interface provides a stream of type `M` for incoming WebSocket messages.
/// - \[M\]: The type of the response model that extends `JGBaseResponseModel`.
abstract class IWebSocketMixin<M extends JGBaseResponseModel> {
  /// A private stream of incoming WebSocket messages of type `M`.
  Stream<M> get _stream;
}

/// A mixin class that implements WebSocket functionality for handling messages and streams.
///
/// This mixin provides methods for sending messages and mapping incoming WebSocket messages
/// to specific response models.
/// - \[M\]: The type of the response model that extends `JGBaseResponseModel`.
abstract mixin class WebSocketMixin<M extends JGBaseResponseModel> implements IWebSocketMixin<M> {

  /// The WebSocket base instance used for communication.
  IWebSocketBase get ws;

  /// Sends a message through the WebSocket.
  ///
  /// - \[message\]: The request model to send, which is converted to JSON format.
  void sendMessage(JGBaseRequestModel message) {
    ws._sendMessage(message._toJson());
  }

  /// A private stream of incoming WebSocket messages of type `M`.
  ///
  /// This stream maps incoming messages to their corresponding response models
  /// based on the `type` field and filters them to include only messages of type `M`.
  @override
  Stream<M> get _stream {
    return ws._getIncomingMessageStream()
        .map((m) => mapTypeToResponse[m['type']]?.call(m))
        .where((m) => m is M)
        .cast<M>();
  }

  /// A map that associates message types with their corresponding response model constructors.
  ///
  /// The key is the message type as a `String`, and the value is a function that takes
  /// a `Map<String, dynamic>` and returns an instance of type `M`.
  Map<String, M Function(Map<String, dynamic>)> get mapTypeToResponse;
}