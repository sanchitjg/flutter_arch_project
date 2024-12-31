part of '../../../flutter_arch_project.dart';

mixin CacheStateMixin {
  @protected
  Map<Type, ICacheState> get caches;

  @protected
  T? cache<T extends ICacheState>() {
    return caches[T] as T?;
  }

  @protected
  Stream<IRepoModel> cacheStream() {
    return StreamGroup.merge(caches.values.map((c) => c._stream())).asBroadcastStream();
  }
}

extension SetExtension<T extends Object> on Set<T> {
  Map<Type, T> toTypeMap() {
    return this.toList().asMap().map((_, value) => MapEntry(value.runtimeType, value));
  }
}