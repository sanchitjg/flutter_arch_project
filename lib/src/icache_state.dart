part of flutter_arch_project;

/// An abstract class that provides a caching mechanism with a stream-based notification system.
/// [T] is here to define the various ways in which this cache can be updated.
/// this can be an integer.
  /*
    int
    0
    1
    2
    3
  */
/// this can be an enum.
 /*
    enum CacheUpdateType {
      UserNameUpdated,
      UserStatsUpdated,
      MobileNoUpdated,
    }
 */
/// or this can be an abstract class
  /*
  * abstract class CacheUpdateType {}
  *
  * class UserNameUpdated {
  *   final String name;
  *   const UserNameUpdated(this.name);
  * }
  *
  * class UserStatsUpdated {
  *   final int cashGameCount;
  *   final int practiceGameCount;
  *   final int cashGameWin;
  *   final int practiceGameWin;
  *
  *   const UserStatsUpdated({
  *     required this.cashGameCount,
  *     required this.practiceGameCount,
  *     required this.cashGameWin,
  *     required this.practiceGameWin,
  *   });
  * }
  *
  * class MobileNoUpdated {
  *   final String mobileNo;
  *   const MobileNoUpdated(this.mobileNo);
  * }
  *
  * */
abstract class ICacheState<T> {

  /// A broadcast stream controller to manage cache updates.
  final _cacheController = StreamController<T>.broadcast();

  /// Subscribes to the cache updates.
  ///
  /// [callback] is a function that will be called with the updated data whenever the cache is updated.
  /// Returns a [StreamSubscription] that can be used to manage the subscription.
  StreamSubscription<T> subscribe(Function(T) callback){
    return _cacheController.stream.listen(callback);
  }

  /// Notifies all listeners with the updated data.
  ///
  /// [cacheUpdateType] is the updated state to be sent to all listeners.
  void notifyListeners(T cacheUpdateType){
    _cacheController.add(cacheUpdateType);
  }

  /// Closes the stream controller and releases resources.
  void dispose(){
    _cacheController.close();
  }
}