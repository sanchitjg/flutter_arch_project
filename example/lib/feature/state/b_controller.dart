import 'dart:async';

import 'package:example/app_cache_state/app_state.dart';
import 'package:example/feature/state/a_repo.dart';
import 'package:flutter_arch_project/flutter_arch_project.dart';

import '../ui/view_models.dart';

class AppController extends IController {

  StreamSubscription<AppStateType>? _counterCacheSub;

  late final appState = cache<AppState>();
  late final appRepo = repo<IAppRepository>();

  AppController({super.repositories, super.caches}){

    _counterCacheSub ??= appState?.subscribe((appStateChange){
      switch(appStateChange) {
        case CounterStateChange():
          addEvent(SetCount(appState?.counter ?? 0));
          break;
        default:
          break;
      }
    });

    final value = appRepo?.getCounter();
    addEvent(SetCount(value ?? 0));
    appState?.setCounter(value ?? 0);
    appRepo?.getCounters();
  }

  void incrementCounter() {
    addEvent(Increment());
    appRepo?.setCounter(bloc<MyHomePageBodyVM>()?.state.counter ?? 0);
  }

  @override
  void dispose(){
    _counterCacheSub?.cancel();
    _counterCacheSub = null;
    super.dispose();
  }

  @override
  void onSocketData(JGBaseResponseModel message) {
    switch(message) {
      case PongModel():
        bloc<MyHomePageBodyVM>()?.add(SetCount(0));
        appState?.setCounter(0);
        break;
      default:
        break;
    }
  }

  @override
  void onRegisterBlocWithController(JGBloc model) {
    switch(model) {
      case MyHomePageVM():
        model.add(TitleEvent('${model.state.title}: Arch Project Example'));
        break;
      case MyHomePageBodyVM():
        model.add(SetCount(appState?.counter ?? 0));
        break;
      default:
        break;
    }
  }

}
