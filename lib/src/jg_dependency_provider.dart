part of flutter_arch_project;

/// A generic dependency provider class that extends the `Provider` class.
/// This class is used to provide dependencies of type `T` to the widget tree.
class JGDependencyProvider<T> extends Provider<T> {
  /// Creates a `JGDependencyProvider` instance.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[child\]: The child widget that will have access to the provided dependency.
  /// - \[create\]: A function that creates the dependency of type `T`.
  /// - \[dispose\]: An optional function to dispose of the dependency.
  /// - \[lazy\]: Whether the dependency should be lazily created. Defaults to `true`.
  /// - \[builder\]: An optional builder function for additional customization.
  JGDependencyProvider({
    super.key,
    super.child,
    required super.create,
    super.dispose,
    super.lazy,
    super.builder,
  });

  /// Creates a `JGDependencyProvider` instance with a pre-existing value.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[value\]: The pre-existing value of type `T` to be provided.
  /// - \[updateShouldNotify\]: An optional function to determine if the widget should rebuild.
  /// - \[builder\]: An optional builder function for additional customization.
  /// - \[child\]: The child widget that will have access to the provided value.
  JGDependencyProvider.value({
    Key? key,
    required T value,
    UpdateShouldNotify<T>? updateShouldNotify,
    TransitionBuilder? builder,
    Widget? child,
  }) : super.value(
    key: key,
    value: value,
    builder: builder,
    child: child,
    updateShouldNotify: updateShouldNotify,
  );
}

/// A private controller provider class that extends `StatelessWidget`.
/// This class is used to provide a controller of type `T` to the widget tree.
class _JGControllerProvider2<T extends IController> extends StatelessWidget {
  /// An optional key for the widget.
  final Key? key;

  /// A function that creates the controller of type `T`.
  final Create<T> create;

  /// An optional builder function for additional customization.
  final TransitionBuilder? builder;

  /// The child widget that will have access to the provided controller.
  final Widget? child;

  /// An optional function to dispose of the controller.
  final Dispose<T>? dispose;

  /// Creates a `_JGControllerProvider2` instance.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[create\]: A function that creates the controller of type `T`.
  /// - \[builder\]: An optional builder function for additional customization.
  /// - \[child\]: The child widget that will have access to the provided controller.
  /// - \[dispose\]: An optional function to dispose of the controller.
  _JGControllerProvider2({
    this.key,
    required this.create,
    this.builder,
    this.child,
    this.dispose,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      create: create,
      dispose: dispose,
      lazy: false,
      child: child,
      builder: builder,
    );
  }
}

/// A controller provider class that extends the `Provider` class.
/// This class is used to provide a controller of type `T` to the widget tree.
class JGControllerProvider<T extends IController> extends Provider<T> {
  /// Creates a `JGControllerProvider` instance.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[child\]: The child widget that will have access to the provided controller.
  /// - \[create\]: A function that creates the controller of type `T`.
  /// - \[builder\]: An optional builder function for additional customization.
  JGControllerProvider({
    super.key,
    super.child,
    required super.create,
    super.builder,
  }) : super(
    lazy: false,
    dispose: (context, value) => value.dispose(),
  );

  /// Creates a `JGControllerProvider` instance with a pre-existing value.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[value\]: The pre-existing value of type `T` to be provided.
  /// - \[builder\]: An optional builder function for additional customization.
  /// - \[child\]: The child widget that will have access to the provided value.
  JGControllerProvider.value({
    Key? key,
    required T value,
    TransitionBuilder? builder,
    Widget? child,
  }) : super.value(
    key: key,
    value: value,
    builder: builder,
    child: child,
  );
}