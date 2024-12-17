part of flutter_arch_project;

abstract class ICacheState<T extends IRepoModel> {

  final _cacheController = StreamController<T>.broadcast();

  Stream<T> _stream(){
    return _cacheController.stream;
  }

  void notifyListeners(T cacheUpdateType){
    _cacheController.add(cacheUpdateType);
  }

  void dispose(){
    _cacheController.close();
  }
}