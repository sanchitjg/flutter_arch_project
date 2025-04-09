part of flutter_arch_project;

/// An abstract base class for a `JGBloc`, which is a specialized implementation of the `Bloc` class.
///
/// This class manages events of type `E` and states of type `S`.
/// - \[E\]: The type of events that the `JGBloc` handles, which must extend `JGBlocEvent`.
/// - \[S\]: The type of states that the `JGBloc` emits, which must extend `JGBlocState`.
abstract class JGBloc<E extends JGBlocEvent, S extends JGBlocState> extends Bloc<E, S> {

  /// Constructs a `JGBloc` with the given initial state.
  ///
  /// - \[initialState\]: The initial state of the `JGBloc`.
  JGBloc(super.initialState) {
    on<E>((event, emit) {
      onEventStateChange(event).forEach(emit.call);
    });
  }

  /// Closes the `JGBloc` and releases any resources.
  ///
  /// This method is marked as `@mustCallSuper` to ensure that the superclass's `close` method is called.
  ///
  /// Returns a `Future` that completes when the `JGBloc` is closed.
  @override
  @mustCallSuper
  @protected
  Future<void> close() {
    return super.close();
  }

  /// Handles the state changes for a given event.
  ///
  /// - \[event\]: The event of type `E` that triggers the state change.
  ///
  /// Returns a `Stream` of states of type `S` that are emitted in response to the event.
  Stream<S> onEventStateChange(E event);

  /// Adds an event to the `JGBloc` if it is not closed and the event is of type `E`.
  ///
  /// - \[event\]: The event to add, which must extend `JGBlocEvent`.
  void _addEvent(JGBlocEvent event) {
    if (!isClosed && event is E) {
      super.add(event);
    }
  }
}