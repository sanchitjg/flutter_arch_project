import 'dart:ui';

import 'package:flutter_arch_project/flutter_arch_project.dart';

class MyHomePageBodyVM extends ViewModel {
  late final counter = VMState(0).reactive(notify);
  late final description = VMState('Counter App Description');
}

class MyHomePageVM extends ViewModel {
  late final title = VMState('Counter App');
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