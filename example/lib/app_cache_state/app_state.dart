import 'package:flutter_arch_project/flutter_arch_project.dart';

class AppState extends ICacheState {

  int _counter = 0;
  int get counter => _counter;

  void setCounter(int value) {
    _counter = value;
    updateCache();
  }
}