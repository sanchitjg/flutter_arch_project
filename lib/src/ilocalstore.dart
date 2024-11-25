import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorage {
  /// Save a key-value pair to local storage
  Future<void> saveToLocalStorage(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Get a value from local storage
  Future<String?> getFromLocalStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Remove a value from local storage
  Future<void> removeFromLocalStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}