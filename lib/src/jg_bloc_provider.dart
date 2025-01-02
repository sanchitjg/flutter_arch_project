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
          ._addBlocToController(create(context), key) as P;
    },
  );

}