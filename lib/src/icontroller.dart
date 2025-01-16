part of flutter_arch_project;

abstract class IController {

  // @protected
  // IRepository get repo;

  // late final StreamSubscription<IRepoModel> _socketSubscription = repo._stream
  //     .listen(onUpdateModelReceive);

  final _blocs = <Type, JGBloc>{};

  final _blocLists = <Type, Map<Key, JGBloc>>{};

  final _changeListeners = <Function, StreamSubscription>{};

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
  void attachListener<LM extends IRepoModel, C>(C Function(LM lm) converter, void Function(C change) handler) {
    // _changeListeners[handler] = repo._stream
    //     .where((event) => event is LM)
    //     .cast<LM>()
    //     .map(converter)
    //     .distinct()
    //     .listen(handler);
  }

  @protected
  void detachListener<C>(void Function(C change) handler) {
    _changeListeners[handler]?.cancel();
    _changeListeners.remove(handler);
  }

  // @protected
  // void onUpdateModelReceive(IRepoModel model);

  @protected
  void onRegisterBlocWithController(JGBloc bloc);

  @protected
  void dispose(){
    //_socketSubscription.cancel();
    _changeListeners.forEach((listener, sub) => sub.cancel());
    _changeListeners.clear();
  }
}