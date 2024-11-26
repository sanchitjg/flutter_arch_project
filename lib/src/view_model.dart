part of flutter_arch_project;

abstract class ViewModelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class ViewModelState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class ViewModel<E extends ViewModelEvent, S extends ViewModelState> extends Bloc<E, S> {

  ViewModel(super.initialState){
    on<E>((event, emit) {
      onEventStateChange(event).forEach(emit);
    });
  }

  @override
  @mustCallSuper
  @protected
  Future<void> close() {
    return super.close();
  }

  Stream<S> onEventStateChange(E event);

  void _addEvent(ViewModelEvent event) {
    if(!isClosed && event is E) {
      super.add(event);
    }
  }
}