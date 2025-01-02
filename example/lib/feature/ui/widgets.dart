import 'package:example/app_cache_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch_project/flutter_arch_project.dart';


import '../state/a_repo.dart';
import '../state/b_controller.dart';
import 'view_models.dart';

class MyAppState extends StatelessWidget {

  const MyAppState({super.key});

  @override
  Widget build(BuildContext context) {
    return JGMultiProvider(
      providers: [
        JGDependencyProvider<AppState>(
          create: (context){
            return AppState();
          },
          dispose: (_, cache) => cache.dispose(),
        ),
        JGDependencyProvider<AppController>(
          create: (context){
            return AppController(
              AppRepository(
                ws: MockSocket(),
                caches: {context.read<AppState>()},
              ),
            );
          },
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(/*'Flutter Demo Home Page'*/),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return JGBlocProvider<MyHomePageVM, AppController>(
      create: (context){
        return MyHomePageVM();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: BlocBuilder<MyHomePageVM, TitleState>(
            builder: (context, title) {
              return Text(title.title);
            },
          ),
        ),
        body: JGBlocProvider<MyHomePageBodyVM, AppController>(
          create: (context) {
            return MyHomePageBodyVM();
          },
          child: Builder(
            builder: (context) {

              final description = context.select<MyHomePageBodyVM, String>(
                    (vm) => vm.state.description,
              );

              final counter = context.select<MyHomePageBodyVM, int>(
                    (vm) => vm.state.counter,
              );

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      description,
                    ),
                    Text(
                      '$counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: context.read<AppController>().incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
