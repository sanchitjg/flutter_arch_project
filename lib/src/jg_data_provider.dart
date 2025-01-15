part of flutter_arch_project;

class JGDataProvider<P extends Cubit> extends BlocProvider<P> {

  const JGDataProvider({
    super.key,
    super.child,
    required super.create,
    super.lazy,
  });

}