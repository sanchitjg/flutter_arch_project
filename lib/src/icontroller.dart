part of flutter_arch_project;

/// An abstract class representing a controller that manages repositories, caches, and view models.
abstract class IController {

  /// A map of repository types to their instances.
  final Map<Type, IRepository> _repositories;

  /// A map of cache state types to their instances.
  final Map<Type, ICacheState> _caches;

  /// A subscription to the merged stream of response models from all repositories.
  late final StreamSubscription<JGBaseResponseModel> _socketSubscription = StreamGroup.mergeBroadcast(_repositories.values
      .map((repo) => repo._stream())
      .whereType<Stream<JGBaseResponseModel>>()).listen(onSocketData);

  /// A map of view model types to their instances.
  final _blocs = <Type, JGBloc>{};

  /// A map of view model types to their keyed instances.
  final _blocLists = <Type, Map<Key, JGBloc>>{};

  /// Constructs an [IController] with the given repositories and caches.
  ///
  /// [repositories] A set of repositories to be managed by the controller.
  /// [caches] A set of cache states to be managed by the controller.
  IController({final repositories = const <IRepository>{}, final caches = const <ICacheState>{}})
      : _repositories = repositories.toList().asMap().map((key, value) => MapEntry(value.runtimeType, value)),
        _caches = caches.toList().asMap().map((key, value) => MapEntry(value.runtimeType, value));

  /// Retrieves a repository of the specified type.
  ///
  /// [T] The type of the repository to retrieve.
  /// Returns the repository instance if found, otherwise null.
  T? repo<T extends IRepository>() {
    return _repositories[T] as T?;
  }

  /// Retrieves a cache state of the specified type.
  ///
  /// [T] The type of the cache state to retrieve.
  /// Returns the cache state instance if found, otherwise null.
  T? cache<T extends ICacheState>() {
    return _caches[T] as T?;
  }

  /// Adds a view model to the controller.
  ///
  /// [T] The type of the view model to add.
  /// [bloc] The view model instance to add.
  /// [key] An optional key to associate with the view model.
  /// Returns the added view model instance.
  T _addBlocToController<T extends JGBloc>(JGBloc bloc, [Key? key]) {
    onRegisterBlocWithController(bloc);
    if(key == null) {
      return _blocs[T] = bloc as T;
    }
    return (_blocLists[T] ??= {})[key] = bloc as T;
  }

  /// Retrieves a view model of the specified type.
  ///
  /// [T] The type of the view model to retrieve.
  /// [key] An optional key to identify the view model.
  /// Returns the view model instance if found and not closed, otherwise null.
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

  /// Adds an event to all view models managed by the controller.
  ///
  /// [event] The event to add to the view models.
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

  /// Handles incoming socket data.
  ///
  /// [message] The response model received from the socket.
  void onSocketData(JGBaseResponseModel message);

  /// Called when a view model is registered with the controller.
  ///
  /// [bloc] The view model that is being registered.
  void onRegisterBlocWithController(JGBloc bloc);

  /// Disposes the controller by canceling the socket subscription.
  void dispose(){
    _socketSubscription.cancel();
  }
}