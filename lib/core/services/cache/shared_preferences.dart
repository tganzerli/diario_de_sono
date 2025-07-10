import 'package:shared_preferences/shared_preferences.dart';

import 'cache_service.dart';

class SharedPreferencesImpl implements Cache {
  static SharedPreferences? _prefs;
  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<String> getData(String key) async {
    await _initPrefs();
    try {
      final result = _prefs!.get(key);

      if (result == null) {
        throw Exception('No value found for key: $key');
      }
      if (result is! String) {
        throw Exception('The result is not a String type');
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> setData(CacheParams params) async {
    await _initPrefs();
    try {
      return await _prefs!.setString(params.key, params.value);
    } catch (e) {
      throw Exception(
        'Failed to save data for key: ${params.key}. Error: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> removeData(String key) async {
    await _initPrefs();
    try {
      return await _prefs!.remove(key);
    } catch (e) {
      throw Exception(
        'Failed to remove data for key: $key. Error: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> clearAll() async {
    await _initPrefs();
    try {
      return await _prefs!.clear();
    } catch (e) {
      throw Exception('Failed to clear all data. Error: ${e.toString()}');
    }
  }
}
