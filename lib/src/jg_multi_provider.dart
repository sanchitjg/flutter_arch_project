part of flutter_arch_project;

/// A custom implementation of `MultiRepositoryProvider`.
/// This class is used to provide multiple repository providers to the widget tree.
class JGMultiProvider extends MultiRepositoryProvider {
  /// Creates a `JGMultiProvider` instance.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[providers\]: A list of repository providers to be added to the widget tree.
  /// - \[child\]: The child widget that will have access to the provided repositories.
  JGMultiProvider({
    super.key,
    required super.providers,
    required super.child,
  });
}

/// A custom implementation of `MultiBlocProvider`.
/// This class is used to provide multiple BLoC providers to the widget tree.
class JGMultiBlocProvider extends MultiBlocProvider {
  /// Creates a `JGMultiBlocProvider` instance.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[providers\]: A list of BLoC providers to be added to the widget tree.
  /// - \[child\]: The child widget that will have access to the provided BLoCs.
  JGMultiBlocProvider({
    super.key,
    required super.providers,
    required super.child,
  });
}