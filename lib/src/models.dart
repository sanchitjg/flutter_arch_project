part of flutter_arch_project;

abstract class GenericModel {
  final String? _type;

  GenericModel._response(Map<String, dynamic> json) : _type = json['type'] as String?;
  GenericModel._request(String? type) : _type = type;
}

abstract class RequestModel extends GenericModel {

  static String? get responseType => null;

  RequestModel({String? type}) : super._request(type);

  Map<String, dynamic>? get mapJson => null;

  Map<String, dynamic> toJson() => {'type': _type, ...?mapJson};
}

abstract class ResponseModel extends GenericModel {

  static String? get requestType => null;

  ResponseModel(Map<String, dynamic> json) : super._response(json);
}