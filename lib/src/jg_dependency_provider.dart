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

class JGControllerProvider<T extends IController> extends Provider<T> {

  JGControllerProvider({
    super.key,
    required Create<T> create,
    super.dispose,
    required Widget Function(BuildContext context) builder,
  }) : super(
    create: (context) {
      final controller = create(context);
      return controller;
    },
    lazy: false,
    builder: (context, _) {
      final controller = context.read()<T>();
      return Provider<IController>.value(
        value: controller,
        builder: (context, _) => builder(context),
      );
    },
  );

  JGControllerProvider.value({
    super.key,
    required T value,
    required Widget Function(BuildContext context) builder,
  }) : super.value(
    value: value,
    builder: (context, _) {
      return Provider<IController>.value(
        value: value,
        builder: (context, _) => builder(context),
      );
    },
  );
}