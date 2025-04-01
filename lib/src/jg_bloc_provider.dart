part of flutter_arch_project;

//TODO: Casting to a specific type based on passed Generics
class JGBlocProvider<P extends JGBloc, T extends IController> extends BlocProvider<P> {

  JGBlocProvider({
    super.key,
    super.child,
    required Create<P> create,
    super.lazy,
  }) : super(
    create: (context){
      return context.read<T>()
          ._addBlocToController<P>(create(context), key);
    },
  );

}

class _JGBlocProviderUnsafe<P extends JGBloc> extends BlocProvider<P> {

  _JGBlocProviderUnsafe({
    super.key,
    super.child,
    required Create<P> create,
  }) : super(
    create: (context){
      return context.read<IController>()
          ._addBlocToController<P>(create(context), key);
    },
    lazy: false,
  );
}

//Use this for session/feature level data blocs, that can be shared between different modules.
class JGDataBlocProvider<P extends JGBloc> extends BlocProvider<P> {

  const JGDataBlocProvider({
    super.key,
    super.child,
    required super.create,
  }) : super(lazy: false);
}