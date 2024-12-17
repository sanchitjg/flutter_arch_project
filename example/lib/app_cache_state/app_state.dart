import 'package:flutter_arch_project/flutter_arch_project.dart';

class AppState extends ICacheState<AppStateType> {

  int _counter = 0;
  int get counter => _counter;

  void setCounter(int value) {
    _counter = value;
    notifyListeners(CounterStateChange(counter));
  }
}

abstract class AppStateType extends IRepoModel {}

class CounterStateChange extends AppStateType {
  final int counter;
  CounterStateChange(this.counter);
}