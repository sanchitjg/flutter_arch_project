part of flutter_arch_project;

class JGDependencyProvider<T> extends Provider<T> {

  JGDependencyProvider({
    super.key,
    super.child,
    required super.create,
    super.dispose,
    super.lazy,
    super.builder,
  });

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

class _JGControllerProvider2<T extends IController> extends StatelessWidget {

  final Key? key;
  final Create<T> create;
  final TransitionBuilder? builder;
  final Widget? child;
  final Dispose<T>? dispose;

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
      builder: builder,/*(context, child) {
        final controller = context.read<T>();
        return Provider<IController>.value(
          value: controller,
          builder: builder,
          child: child,
        );
      },*/
    );
  }
}

class JGControllerProvider<T extends IController> extends Provider<T> {

  JGControllerProvider({
    super.key,
    super.child,
    required super.create,
    super.builder,
  }) : super(
    lazy: false,
    dispose: (context, value) => value.dispose(),
  );

  JGControllerProvider.value({
    Key? key,
    required T value,
    TransitionBuilder? builder,
    Widget? child,
  }) : super.value(
    key: key,
    value: value,
    builder: builder,/*(context, child) {
      return Provider<IController>.value(
        value: value,
        builder: builder,
        child: child,
      );
    },*/
    child: child,
  );
}
