part of flutter_arch_project;

abstract class GenericModel {
  final String? _type;

  GenericModel._response(Map<String, dynamic> json) : _type = json['type'] as String?;
  GenericModel._request(String? type) : _type = type;
}

abstract class JGBaseRequestModel extends GenericModel {

  static String? get responseType => null;

  JGBaseRequestModel({String? type}) : super._request(type);

  Map<String, dynamic>? get mapJson => null;

  Map<String, dynamic> toJson() => {'type': _type, ...?mapJson};
}

abstract class JGBaseResponseModel extends GenericModel {

  static String? get requestType => null;

  JGBaseResponseModel(super.json) : super._response();
}