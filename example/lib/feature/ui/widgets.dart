import 'package:example/app_cache_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch_project/flutter_arch_project.dart';
import 'package:provider/provider.dart';

import '../state/a_repo.dart';
import '../state/b_controller.dart';
import 'view_models.dart';

class MyAppState extends StatelessWidget {

  const MyAppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppState>(
          create: (context){
            return AppState();
          },
        ),
        Provider<IAppRepository>(
          create: (context){
            return AppRepository(
              webSockets: {MockSocket()},
            );
          },
        ),
        Provider<AppController>(
          create: (context){
            return AppController(
              repositories: {context.read<AppRepository>()},
              caches: {context.read<AppState>()},
            );
          },
        ),
      ],
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

    return VMProvider(
      create: (context){
        return MyHomePageVM();
      },
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Selector<MyHomePageVM, String>(
              selector: (context, vm) => vm.title.get(),
              builder: (context, title, _) {
                return Text(title);
              },
            ),
          ),
          body: Provider<MyHomePageBodyVM>(
            create: (context) {
              return MyHomePageBodyVM();
            },
            builder: (context, _) {

              final description = context.select<MyHomePageBodyVM, String>(
                    (vm) => vm.description.get(),
              );

              final counter = context.select<MyHomePageBodyVM, int>(
                    (vm) => vm.counter.get(),
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
          floatingActionButton: FloatingActionButton(
            onPressed: context.read<AppController>().incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
