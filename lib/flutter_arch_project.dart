library flutter_arch_project;

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:jg_network/network_main.dart';
export 'package:flutter_arch_project/flutter_arch_project.dart';

import 'dart:async';

import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:jg_network/network_main.dart';
import 'package:rummy_building_blocks/rummy_building_blocks.dart';

part 'src/icache_state.dart';
part 'src/icontroller.dart';
part 'src/iwebsocket.dart';
part 'src/ihttp.dart';

part 'src/models.dart';

part 'src/irepository/irepository.dart';
part 'src/irepository/data_sources_mixins/cache_state_mixin.dart';
part 'src/irepository/data_sources_mixins/http_mixin.dart';
part 'src/irepository/data_sources_mixins/local_store_mixin.dart';
part 'src/irepository/data_sources_mixins/web_socket_mixin.dart';
part 'src/irepository/data_sources_mixins/update_stream_mixin.dart';

part 'src/jg_bloc/jg_bloc.dart';
part 'src/jg_bloc/jg_bloc_state.dart';
part 'src/jg_bloc/jg_bloc_event.dart';

part 'src/jg_bloc_provider.dart';
part 'src/jg_dependency_provider.dart';
part 'src/jg_multi_provider.dart';