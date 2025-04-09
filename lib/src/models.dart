part of flutter_arch_project;

/// An abstract class representing a repository model.
/// This class extends `Equatable` to provide value equality.
abstract class IRepoModel extends Equatable {}

/// An abstract class representing a generic socket model.
/// It extends `IRepoModel` and provides a base for socket-related models.
abstract class GenericSocketModel extends IRepoModel {
  /// The type of the socket model, which can be null.
  final String? _type;

  /// Constructor for creating a `GenericSocketModel` from a response.
  ///
  /// \[json\] - A map containing the JSON data to initialize the model.
  GenericSocketModel._response(Map<String, dynamic> json) : _type = json['type'] as String?;

  /// Constructor for creating a `GenericSocketModel` for a request.
  ///
  /// \[type\] - The type of the request, which can be null.
  GenericSocketModel._request(String? type) : _type = type;
}

/// An abstract class representing a base request model.
/// It extends `GenericSocketModel` and provides additional functionality for requests.
abstract class JGBaseRequestModel extends GenericSocketModel {
  /// A static getter for the response type, which is null by default.
  static String? get responseType => null;

  /// Constructor for creating a `JGBaseRequestModel`.
  ///
  /// \[type\] - The type of the request, which is required.
  JGBaseRequestModel({required String type}) : super._request(type);

  /// A getter for the JSON map representation of the model, which is null by default.
  Map<String, dynamic>? get mapJson => null;

  /// Converts the model to a JSON map.
  ///
  /// Returns a map containing the type and additional JSON data.
  Map<String, dynamic> _toJson() => {'type': _type, ...?mapJson};
}

/// An abstract class representing a base response model.
/// It extends `GenericSocketModel` and provides additional functionality for responses.
abstract class JGBaseResponseModel extends GenericSocketModel {
  /// A static getter for the request type, which is null by default.
  static String? get requestType => null;

  /// Constructor for creating a `JGBaseResponseModel` from a JSON response.
  ///
  /// \[json\] - A map containing the JSON data to initialize the model.
  JGBaseResponseModel(super.json) : super._response();
}