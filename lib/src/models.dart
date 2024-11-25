abstract class GenericModel {
  final String? type;

  GenericModel(Map<String, dynamic> json) : type = json['type'] as String?;
  GenericModel._(this.type);
}

abstract class RequestModel extends GenericModel {

  static String? get responseType => null;

  RequestModel({String? type}) : super._(type);

  Map<String, dynamic>? get mapJson => null;

  Map<String, dynamic> toJson() => {'type': type, ...?mapJson};
}

abstract class ResponseModel extends GenericModel {

  static String? get requestType => null;

  ResponseModel(super.json);
}