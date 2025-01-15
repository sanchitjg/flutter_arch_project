import 'package:example/app_cache_state/app_state.dart';
import 'package:example/feature/state/a_repo.dart';
import 'package:flutter_arch_project/flutter_arch_project.dart';

import '../ui/view_models.dart';

class AppController extends IController {

  @override
  final IAppRepository repo;

  AppController(this.repo){
    final value = repo.getCounter();
    addEvent(SetCount(value ?? 0));
    repo.cacheCounter(value ?? 0);
    repo.getCounters();
  }

  void incrementCounter() {
    addEvent(Increment());
    repo.setCounter(bloc<MyHomePageBodyVM>()?.state.counter ?? 0);
  }

  @override
  void onUpdateModelReceive(IRepoModel model) {
    switch(model) {
      case PongModel():
        bloc<MyHomePageBodyVM>()?.add(SetCount(0));
        repo.cacheCounter(0);
        break;
      case AppState():
        addEvent(SetCount(repo.getAppState().counter));
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
        model.add(SetCount(repo.getCachedCounter() ?? 0));
        break;
      default:
        break;
    }
  }

}
