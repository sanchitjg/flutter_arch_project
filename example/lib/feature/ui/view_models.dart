import 'dart:ui';

import 'package:flutter_arch_project/flutter_arch_project.dart';

abstract class CounterEvent extends ViewModelEvent {}

class Increment extends CounterEvent {}

class SetCount extends CounterEvent {
  final int count;

  SetCount(this.count);

  @override
  List<Object?> get props => [count];
}

class CounterState extends ViewModelState {
  final int counter;

  final String description = 'You have pushed the button this many times:';

  CounterState(this.counter);

  @override
  List<Object?> get props => [counter];
}

class MyHomePageBodyVM extends ViewModel<CounterEvent, CounterState> {

  MyHomePageBodyVM() : super(CounterState(0)){}

  @override
  Stream<CounterState> onEventStateChange(CounterEvent event) async* {
    switch(event) {
      case Increment():
        yield CounterState(state.counter+1);
      case SetCount():
        yield CounterState(event.count);
      default:
        yield state;
    }
  }
}

class TitleEvent extends ViewModelEvent {
  final String title;

  TitleEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class TitleState extends ViewModelState {
  final String title;

  TitleState(this.title);

  @override
  List<Object?> get props => [title];
}

class MyHomePageVM extends ViewModel<TitleEvent, TitleState> {
  MyHomePageVM() : super(TitleState('Counter App'));

  @override
  Stream<TitleState> onEventStateChange(TitleEvent event) async* {
    yield state;
  }
}

class VMState<T> {
  T _state;
  T get() => _state;

  VMState<T> set(T value) {
    _state = value;
    _notify?.call();
    return this;
  }

  final VoidCallback? _notify;

  VMState._(T initialState, VoidCallback? notify)
      : _state = initialState,
        _notify = notify;

  factory VMState(T initialState) => VMState._(initialState, null);

  VMState<T> reactive(VoidCallback notify) => VMState._(_state, notify);

}