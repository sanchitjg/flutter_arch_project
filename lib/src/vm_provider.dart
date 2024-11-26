part of flutter_arch_project;

class VMProvider<P extends ViewModel> extends BlocProvider<P> {

  VMProvider({
    super.key,
    super.child,
    required Create<P> create,
    super.lazy,
  }) : super(
    create: (context){
      return context.read<IController>()
          ._addVM(create(context), key) as P;
    },
  );

}