part of flutter_arch_project;

class JGBlocProvider<P extends JGBloc> extends BlocProvider<P> {

  JGBlocProvider({
    super.key,
    super.child,
    required Create<P> create,
    super.lazy,
  }) : super(
    create: (context){
      return context.read<IController>()
          ._addBlocToController(create(context), key) as P;
    },
  );

}