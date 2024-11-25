import 'dart:async';

abstract class ICacheState<T> {

  final _cacheController = StreamController<T>.broadcast();

  StreamSubscription<T> subscribe(Function(T) callback){
    return _cacheController.stream.listen(callback);
  }

  void notifyListeners(T data){
    _cacheController.add(data);
  }

  void dispose(){
    _cacheController.close();
  }
}