import 'dart:async';

import 'package:example/app_cache_state/app_state.dart';
import 'package:example/feature/state/a_repo.dart';
import 'package:flutter_arch_project/flutter_arch_project.dart';

import '../ui/view_models.dart';

class AppController extends IController {

  StreamSubscription<AppStateType>? _counterCacheSub;

  AppController({super.repositories, super.caches}){

    _counterCacheSub ??= cache<AppState>()?.subscribe((appState){
      switch(appState) {
        case AppStateType.counter:
          vm<MyHomePageBodyVM>()?.counter.set(cache<AppState>()?.counter ?? 0);
          break;
        default:
          break;
      }
    });

    repo<IAppRepository>()?.getCounter().then((value) {
      vm<MyHomePageBodyVM>()?.counter.set(value ?? 0);
      cache<AppState>()?.setCounter(value ?? 0);
    });
    repo<IAppRepository>()?.getCounters()?.then((value) {
      vm<MyHomePageBodyVM>()?.counter.set(value.firstOrNull ?? 0);
      cache<AppState>()?.setCounter(value.firstOrNull ?? 0);
    });
  }

  void incrementCounter() {
    vm<MyHomePageBodyVM>()
        ?.counter
        .set((vm<MyHomePageBodyVM>()?.counter.get() ?? 0) + 1);
    repo<IAppRepository>()
        ?.setCounter(vm<MyHomePageBodyVM>()?.counter.get() ?? 0);
  }

  void dispose(){
    _counterCacheSub?.cancel();
    _counterCacheSub = null;
  }

}
