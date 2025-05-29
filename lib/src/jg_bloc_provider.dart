part of flutter_arch_project;

/// A custom `BlocProvider` implementation that links a `JGBloc` with a specific `IController`.
/// This provider ensures that the `JGBloc` is added to the associated controller.
///
/// - \[P\]: The type of the `JGBloc`.
/// - \[T\]: The type of the `IController`.
class JGBlocProvider<P extends JGBloc, T extends IController> extends BlocProvider<P> {
  /// Creates a `JGBlocProvider` instance.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[child\]: The child widget that will have access to the provided `JGBloc`.
  /// - \[create\]: A function that creates the `JGBloc` of type `P`.
  /// - \[lazy\]: Whether the `JGBloc` should be lazily created. Defaults to `true`.
  JGBlocProvider({
    super.key,
    super.child,
    required Create<P> create,
    super.lazy,
  }) : super(
    create: (context) {
      return context.read<T>()
          ._addBlocToController<P>(create(context), key);
    },
  );
}

/// A private `BlocProvider` implementation that links a `JGBloc` with the default `IController`.
/// This provider is not lazy and is intended for internal use only.
///
/// - \[P\]: The type of the `JGBloc`.
class _JGBlocProviderUnsafe<P extends JGBloc> extends BlocProvider<P> {
  /// Creates a `_JGBlocProviderUnsafe` instance.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[child\]: The child widget that will have access to the provided `JGBloc`.
  /// - \[create\]: A function that creates the `JGBloc` of type `P`.
  _JGBlocProviderUnsafe({
    super.key,
    super.child,
    required Create<P> create,
  }) : super(
    create: (context) {
      return context.read<IController>()
          ._addBlocToController<P>(create(context), key);
    },
    lazy: false,
  );
}

/// A `BlocProvider` implementation for session or feature-level data blocs.
/// This provider is not lazy and is designed for sharing `JGBloc` instances between modules.
///
/// - \[P\]: The type of the `JGBloc`.
class JGDataBlocProvider<P extends JGBloc> extends BlocProvider<P> {
  /// Creates a `JGDataBlocProvider` instance.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[child\]: The child widget that will have access to the provided `JGBloc`.
  /// - \[create\]: A function that creates the `JGBloc` of type `P`.
  const JGDataBlocProvider({
    super.key,
    super.child,
    required super.create,
  }) : super(lazy: false);
}