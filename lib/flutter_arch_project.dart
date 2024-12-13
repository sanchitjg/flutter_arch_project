library flutter_arch_project;

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:jg_network/network_main.dart';

import 'dart:async';

import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:jg_network/network_main.dart';
import 'package:rummy_building_blocks/rummy_building_blocks.dart';

part 'src/icache_state.dart';
part 'src/icontroller.dart';
part 'src/iwebsocket.dart';
part 'src/models.dart';
part 'src/irepository.dart';
part 'src/view_model.dart';
part 'src/jg_bloc_provider.dart';
part 'src/jg_dependency_provider.dart';
part 'src/jg_multi_provider.dart';