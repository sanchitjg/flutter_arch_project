import 'package:flutter/foundation.dart';

import 'ihttp.dart';
import 'ilocalstore.dart';
import 'iwebsocket.dart';

class _DefaultLocalStorage extends ILocalStorage {}

abstract class IRepository {
  final Map<Type, IWebSocket> _webSockets;
  final Map<Type, IHttp> _httpCons;

  ILocalStorage get localStore => _DefaultLocalStorage();

  IRepository({final Set<IWebSocket> webSockets = const <IWebSocket>{}, final http = const <IHttp>{}})
      :  _webSockets = webSockets.toList().asMap().map((key, value) => MapEntry(value.runtimeType, value)),
        _httpCons = http.toList().asMap().map((key, value) => MapEntry(value.runtimeType, value));

  @protected
  T? socket<T extends IWebSocket>() {
    return _webSockets[T] as T?;
  }

  @protected
  T? http<T extends IHttp>() {
    return _httpCons[T] as T?;
  }
}