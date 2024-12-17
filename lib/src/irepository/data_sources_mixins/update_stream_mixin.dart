part of '../../../flutter_arch_project.dart';

mixin UpdatesStreamMixin {
  void mergeStream(Set<Stream<IRepoModel>> s) {
    _stream = StreamGroup.merge([_stream, ...s]).asBroadcastStream();
  }
  var _stream = Stream<IRepoModel>.empty().asBroadcastStream();
}