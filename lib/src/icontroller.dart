part of flutter_arch_project;

/// An abstract class representing a controller that manages repositories, caches, and view models.
abstract class IController {

  /// A map of repository types to their instances.
  final Map<Type, IRepository> _repositories;

  /// A map of cache state types to their instances.
  final Map<Type, ICacheState> _caches;

  /// A subscription to the merged stream of response models from all repositories.
  late final StreamSubscription<ResponseModel> _socketSubscription = StreamGroup.mergeBroadcast(_repositories.values
      .map((repo) => repo._stream())
      .whereType<Stream<ResponseModel>>()).listen(onSocketData);

  /// A map of view model types to their instances.
  final _viewModels = <Type, ViewModel>{};

  /// A map of view model types to their keyed instances.
  final _viewModelLists = <Type, Map<Key, ViewModel>>{};

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
  /// [vm] The view model instance to add.
  /// [key] An optional key to associate with the view model.
  /// Returns the added view model instance.
  T _addVM<T extends ViewModel>(ViewModel vm, [Key? key]) {
    onRegisterViewModel(vm);
    if(key == null) {
      return _viewModels[T] = vm as T;
    }
    return (_viewModelLists[T] ??= {})[key] = vm as T;
  }

  /// Retrieves a view model of the specified type.
  ///
  /// [T] The type of the view model to retrieve.
  /// [key] An optional key to identify the view model.
  /// Returns the view model instance if found and not closed, otherwise null.
  T? vm<T extends ViewModel>([Key? key]) {
    if(key == null) {
      if(_viewModels[T]?.isClosed == true) {
        return null;
      }
      return _viewModels[T] as T?;
    }
    if(_viewModelLists[T]?[key]?.isClosed == true) {
      return null;
    }
    return _viewModelLists[T]?[key] as T?;
  }

  /// Adds an event to all view models managed by the controller.
  ///
  /// [event] The event to add to the view models.
  void addEvent(ViewModelEvent event) {
    _viewModels.forEach((_, value) {
      value._addEvent(event);
    });
    _viewModelLists.forEach((_, value) {
      value.forEach((_, vm) {
        vm._addEvent(event);
      });
    });
  }

  /// Handles incoming socket data.
  ///
  /// [message] The response model received from the socket.
  void onSocketData(ResponseModel message);

  /// Called when a view model is registered with the controller.
  ///
  /// [model] The view model that is being registered.
  void onRegisterViewModel(ViewModel model);

  /// Disposes the controller by canceling the socket subscription.
  void dispose(){
    _socketSubscription.cancel();
  }
}