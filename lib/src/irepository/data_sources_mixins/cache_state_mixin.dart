part of '../../../flutter_arch_project.dart';

mixin CacheStateMixin {
  Map<Type, ICacheState> get caches;

  T? cache<T extends ICacheState>() {
    return caches[T] as T?;
  }

  Stream<IRepoModel> cacheStream() {
    return StreamGroup.merge(caches.values.map((c) => c._stream())).asBroadcastStream();
  }
}

extension SetExtension<T extends Object> on Set<T> {
  Map<Type, T> toTypeMap() {
    return this.toList().asMap().map((_, value) => MapEntry(value.runtimeType, value));
  }
}