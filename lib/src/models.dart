part of flutter_arch_project;

abstract class IRepoModel {}

abstract class GenericSocketModel extends IRepoModel {
  final String? _type;

  GenericSocketModel._response(Map<String, dynamic> json) : _type = json['type'] as String?;
  GenericSocketModel._request(String? type) : _type = type;
}

abstract class JGBaseRequestModel extends GenericSocketModel {

  static String? get responseType => null;

  JGBaseRequestModel({String? type}) : super._request(type);

  Map<String, dynamic>? get mapJson => null;

  Map<String, dynamic> toJson() => {'type': _type, ...?mapJson};
}

abstract class JGBaseResponseModel extends GenericSocketModel {

  static String? get requestType => null;

  JGBaseResponseModel(super.json) : super._response();
}