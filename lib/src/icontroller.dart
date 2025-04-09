part of flutter_arch_project;

/// A mixin that provides WebSocket control functionality for managing WebSocket streams and listeners.
///
/// - \[M\]: The type of the response model that extends `JGBaseResponseModel`.
mixin WebSocketControlMixin<M extends JGBaseResponseModel> {
  /// The repository that implements the `IWebSocketMixin` interface.
  @protected
  IWebSocketMixin<M> get repo;

  /// The subscription to the WebSocket stream.
  StreamSubscription<M>? _socketSubscription;

  /// A map of change listeners and their corresponding stream subscriptions.
  final _changeListeners = <Function, StreamSubscription>{};

  /// Initializes the WebSocket by subscribing to the repository's stream.
  void initSocket() {
    _socketSubscription ??= repo._stream.listen(onUpdateModelReceive);
  }

  /// Called when a new model is received from the WebSocket stream.
  ///
  /// - \[model\]: The received model of type `M`.
  @protected
  void onUpdateModelReceive(M model);

  /// Attaches a listener to the WebSocket stream for a specific type of model.
  ///
  /// - \[LM\]: The type of the model to listen for, which extends `M`.
  /// - \[C\]: The type of the change to be handled.
  /// - \[converter\]: A function that converts the model of type `LM` to a change of type `C`.
  /// - \[handler\]: A function that handles the change of type `C`.
  @protected
  void attachListener<LM extends M, C>(
      C Function(LM lm) converter, void Function(C change) handler) {
    _changeListeners[handler] = repo._stream
        .where((event) => event is LM)
        .cast<LM>()
        .map(converter)
        .distinct()
        .listen(handler);
  }

  /// Detaches a listener from the WebSocket stream.
  ///
  /// - \[C\]: The type of the change handled by the listener.
  /// - \[handler\]: The function that handles the change of type `C`.
  @protected
  void detachListener<C>(void Function(C change) handler) {
    _changeListeners[handler]?.cancel();
    _changeListeners.remove(handler);
  }

  /// Disposes of the WebSocket by canceling all subscriptions and clearing listeners.
  @mustCallSuper
  void disposeSocket() {
    _changeListeners.forEach((listener, sub) => sub.cancel());
    _changeListeners.clear();
    _socketSubscription?.cancel();
    _socketSubscription = null;
  }
}

/// An abstract class that defines the base functionality for a controller.
///
/// This class manages `JGBloc` instances and provides methods for adding, retrieving, and handling events.
abstract class IController {
  /// Creates an `IController` instance.
  ///
  /// - \[dataBlocs\]: An optional set of `JGBloc` instances to initialize the controller with.
  IController([Set<JGBloc>? dataBlocs])
      : _blocs = dataBlocs?.toList().asMap().map((key, value) => MapEntry(value.runtimeType, value)) ?? <Type, JGBloc>{};

  /// A map of `JGBloc` instances keyed by their runtime type.
  final Map<Type, JGBloc> _blocs;

  /// A map of `JGBloc` lists keyed by their runtime type and an optional key.
  final _blocLists = <Type, Map<Key, JGBloc>>{};

  /// Adds a `JGBloc` to the controller.
  ///
  /// - \[T\]: The type of the `JGBloc`.
  /// - \[bloc\]: The `JGBloc` instance to add.
  /// - \[key\]: An optional key to associate with the `JGBloc`.
  ///
  /// Returns the added `JGBloc` instance.
  T _addBlocToController<T extends JGBloc>(T bloc, [Key? key]) {
    onRegisterBlocWithController(bloc);
    if (key == null) {
      _blocs[bloc.runtimeType] = bloc;
      return bloc;
    }
    return (_blocLists[T] ??= {})[key] = bloc;
  }

  /// Retrieves a `JGBloc` from the controller.
  ///
  /// - \[T\]: The type of the `JGBloc`.
  /// - \[key\]: An optional key to retrieve a specific `JGBloc` instance.
  ///
  /// Returns the `JGBloc` instance or `null` if not found or closed.
  @protected
  T? bloc<T extends JGBloc>([Key? key]) {
    if (key == null) {
      if (_blocs[T]?.isClosed == true) {
        return null;
      }
      return _blocs[T] as T?;
    }
    if (_blocLists[T]?[key]?.isClosed == true) {
      return null;
    }
    return _blocLists[T]?[key] as T?;
  }

  /// Adds an event to all `JGBloc` instances managed by the controller.
  ///
  /// - \[event\]: The `JGBlocEvent` to add.
  @protected
  void addEvent(JGBlocEvent event) {
    _blocs.forEach((_, value) {
      value._addEvent(event);
    });
    _blocLists.forEach((_, value) {
      value.forEach((_, bloc) {
        bloc._addEvent(event);
      });
    });
  }

  /// Called when a `JGBloc` is registered with the controller.
  ///
  /// - \[bloc\]: The `JGBloc` instance being registered.
  @protected
  void onRegisterBlocWithController(JGBloc bloc) {}

  /// Disposes of the controller and its resources.
  void dispose() {}
}