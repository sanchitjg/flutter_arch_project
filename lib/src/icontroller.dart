part of flutter_arch_project;

abstract class IController {

  IRepository get repo;

  late final StreamSubscription<IRepoModel> _socketSubscription = repo._stream
      .listen(onUpdateModelReceive);

  final _blocs = <Type, JGBloc>{};

  final _blocLists = <Type, Map<Key, JGBloc>>{};

  T _addBlocToController<T extends JGBloc>(JGBloc bloc, [Key? key]) {
    onRegisterBlocWithController(bloc);
    if(key == null) {
      return _blocs[T] = bloc as T;
    }
    return (_blocLists[T] ??= {})[key] = bloc as T;
  }

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

  void onUpdateModelReceive(IRepoModel model);

  void onRegisterBlocWithController(JGBloc bloc);

  void dispose(){
    _socketSubscription.cancel();
  }
}