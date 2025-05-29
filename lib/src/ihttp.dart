part of flutter_arch_project;

/// An interface defining the HTTP contract for the application.
/// This interface includes a method to handle scenarios where the authentication token has expired.
abstract class IHttp {
  /// Called when the authentication token has expired.
  ///
  /// Returns a `Future` that resolves to a new authentication token as a `String`.
  Future<String> onAuthTokenExpired();
}