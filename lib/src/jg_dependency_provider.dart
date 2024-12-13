part of flutter_arch_project;

class JGDependencyProvider<T> extends Provider<T> {

  JGDependencyProvider({
    super.key,
    super.child,
    required super.create,
    super.dispose,
    super.lazy,
  });

}