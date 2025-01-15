part of flutter_arch_project;

abstract class JGBloc<E extends JGBlocEvent, S extends JGBlocState> extends Bloc<E, S> {

  JGBloc(super.initialState){
    on<E>((event, emit) {
      onEventStateChange(event).forEach(emit.call);
    });
  }

  @override
  @mustCallSuper
  @protected
  Future<void> close() {
    return super.close();
  }

  Stream<S> onEventStateChange(E event);

  void _addEvent(JGBlocEvent event) {
    if(!isClosed && event is E) {
      super.add(event);
    }
  }
}