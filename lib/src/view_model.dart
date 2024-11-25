import 'package:flutter/foundation.dart';

abstract class ViewModel extends ChangeNotifier {

  bool _disposed = false;

  bool get isDisposed => _disposed;

  @override
  @mustCallSuper
  @protected
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void notify() {
    if(!_disposed) {
      notifyListeners();
    }
  }
}