part of flutter_arch_project;

mixin WebSocketControlMixin<M extends JGBaseResponseModel> {
  @protected
  IWebSocketMixin<M> get repo;

  StreamSubscription<M>? _socketSubscription;

  final _changeListeners = <Function, StreamSubscription>{};

  void initSocket() {
    _socketSubscription ??= repo._stream
        .listen(onUpdateModelReceive);
  }

  @protected
  void onUpdateModelReceive(M model);

  @protected
  void attachListener<LM extends M, C>(C Function(LM lm) converter, void Function(C change) handler) {
    _changeListeners[handler] = repo._stream
        .where((event) => event is LM)
        .cast<LM>()
        .map(converter)
        .distinct()
        .listen(handler);
  }

  @protected
  void detachListener<C>(void Function(C change) handler) {
    _changeListeners[handler]?.cancel();
    _changeListeners.remove(handler);
  }

  @mustCallSuper
  void disposeSocket(){
    _changeListeners.forEach((listener, sub) => sub.cancel());
    _changeListeners.clear();
    _socketSubscription?.cancel();
    _socketSubscription = null;
  }
}

abstract class IController {
  IController([Set<JGBloc>? dataBlocs]) :
        _blocs = dataBlocs?.toList().asMap()
            .map((key, value) => MapEntry(value.runtimeType, value))
            ?? <Type, JGBloc>{};

  final Map<Type, JGBloc> _blocs;

  final _blocLists = <Type, Map<Key, JGBloc>>{};

  T _addBlocToController<T extends JGBloc>(T bloc, [Key? key]) {
    onRegisterBlocWithController(bloc);
    if(key == null) {
      _blocs[bloc.runtimeType] = bloc;

      return bloc;
    }
    return (_blocLists[T] ??= {})[key] = bloc;
  }

  @protected
  T? bloc<T extends JGBloc>([Key? key]) {
    if(key == null) {
      if(_blocs[T]?.isClosed == true) {
        return null;
      }
      return _blocs[T] as T?;
    }
    if(_blocLists[T]?[key]?.isClosed == true) {
      return null;
    }
    return _blocLists[T]?[key] as T?;
  }

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

  @protected
  void onRegisterBlocWithController(JGBloc bloc){}

  void dispose() {}

}