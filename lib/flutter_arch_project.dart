/// The `flutter_arch_project` library serves as the main entry point for the project.
/// It provides exports and imports for various dependencies and internal components
/// required for the architecture of the Flutter application.

library flutter_arch_project;

/// Exporting the `flutter_bloc` package to provide BLoC (Business Logic Component)
/// functionality for state management.
export 'package:flutter_bloc/flutter_bloc.dart';
// export 'package:jg_network/network_main.dart' show HttpProvider; // Uncomment if HttpProvider is needed.

import 'dart:async'; // Provides support for asynchronous programming.

import 'package:equatable/equatable.dart'; // Used for value equality in Dart objects.
import 'package:flutter/material.dart'; // Provides Flutter's core UI components.
import 'package:flutter_bloc/flutter_bloc.dart'; // Provides BLoC pattern implementation.
import 'package:provider/provider.dart'; // Used for dependency injection and state management.

/// Part files included in the library.
/// These files define various interfaces, models, and implementations
/// that are part of the project's architecture.

part 'src/icontroller.dart'; // Defines the IController interface.
part 'src/iwebsocket.dart'; // Defines the IWebSocket interface.
part 'src/ihttp.dart'; // Defines the IHttp interface.

part 'src/models.dart'; // Contains data models used across the project.

part 'src/irepository/data_sources_mixins/web_socket_mixin.dart';
// Provides a mixin for WebSocket-related functionality.

part 'src/jg_bloc/jg_bloc.dart'; // Defines the JGBloc class for state management.
part 'src/jg_bloc/jg_bloc_state.dart'; // Defines the states used by JGBloc.
part 'src/jg_bloc/jg_bloc_event.dart'; // Defines the events used by JGBloc.

part 'src/jg_bloc_provider.dart'; // Provides a BLoC provider for dependency injection.
part 'src/jg_data_provider.dart'; // Manages data-related dependencies.
part 'src/jg_dependency_provider.dart'; // Manages general dependency injection.
part 'src/jg_multi_provider.dart'; // Combines multiple providers for dependency injection.