part of flutter_arch_project;

abstract class ICacheState extends IRepoModel {

  final _cacheController = StreamController<ICacheState>.broadcast();

  Stream<ICacheState> _stream(){
    return _cacheController.stream;
  }

  void updateCache(){
    _cacheController.add(this);
  }

  void dispose(){
    _cacheController.close();
  }
}