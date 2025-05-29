part of flutter_arch_project;

/// A custom data provider class that extends `BlocProvider`.
/// This class is used to provide a `Cubit` of type `P` to the widget tree.
class JGDataProvider<P extends Cubit> extends BlocProvider<P> {
  /// Creates a `JGDataProvider` instance.
  ///
  /// - \[key\]: An optional key for the widget.
  /// - \[child\]: The child widget that will have access to the provided `Cubit`.
  /// - \[create\]: A function that creates the `Cubit` of type `P`.
  /// - \[lazy\]: Whether the `Cubit` should be lazily created. Defaults to `true`.
  const JGDataProvider({
    super.key,
    super.child,
    required super.create,
    super.lazy,
  });
}