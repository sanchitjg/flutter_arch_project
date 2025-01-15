import 'package:flutter_arch_project/flutter_arch_project.dart';

class AppDataBloc extends JGBloc<AppDataEvent, AppState> {

  int _counter = 0;

  AppDataBloc(super.initialState);
  int get counter => _counter;

  void setCounter(int value) {
    _counter = value;
  }

  @override
  Stream<AppState> onEventStateChange(AppDataEvent event) async* {
    emit(state);
  }
}

class AppDataEvent extends JGBlocEvent {
  AppDataEvent();
}

class AppState extends JGBlocState {
  int counter;

  AppState({this.counter = 0});
}