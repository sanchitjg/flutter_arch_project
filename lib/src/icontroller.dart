import 'package:flutter/foundation.dart';

import 'icache_state.dart';
import 'irepository.dart';
import 'view_model.dart';

abstract class IController {

  final Map<Type, IRepository> _repositories;
  final Map<Type, ICacheState> _caches;

  final _viewModels = <Type, ViewModel>{};
  final _viewModelLists = <Type, Map<Key, ViewModel>>{};

  IController({final repositories = const <IRepository>{}, final caches = const <ICacheState>{}})
      : _repositories = repositories.toList().asMap().map((key, value) => MapEntry(value.runtimeType, value)),
        _caches = caches.toList().asMap().map((key, value) => MapEntry(value.runtimeType, value));

  T? repo<T extends IRepository>() {
    return _repositories[T] as T?;
  }

  T? cache<T extends ICacheState>() {
    return _caches[T] as T?;
  }

  ///this is not to be called directly from the controller
  T addVM<T extends ViewModel>(ViewModel vm, [Key? key]) {
    if(key == null) {
      return _viewModels[T] = vm as T;
    }

    return (_viewModelLists[T] ??= {})[key] = vm as T;
  }

  @protected
  T? vm<T extends ViewModel>([Key? key]) {
    if(key == null) {
      if(_viewModels[T]?.isDisposed == true) {
        return null;
      }
      return _viewModels[T] as T?;
    }

    if(_viewModelLists[T]?[key]?.isDisposed == true) {
      return null;
    }
    return _viewModelLists[T]?[key] as T?;
  }
}