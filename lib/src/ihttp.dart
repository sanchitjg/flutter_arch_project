part of flutter_arch_project;

abstract class IHttp {
  Future<String> onAuthTokenExpired();
}