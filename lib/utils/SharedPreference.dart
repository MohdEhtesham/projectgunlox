import 'dart:async' show Future;
import 'dart:convert' show json;

import 'package:shared_preferences/shared_preferences.dart';

class GunLoxPrefs {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<SharedPreferences> _getInstance() {
    return _prefs;
  }

  static Future<bool> remove(String key) async {
    return (await _getInstance()).remove(key);
  }

  static Future<String> getString(String key) async {
    return (await _getInstance()).getString(key) ?? '';
  }

  static Future<String> setString(String key, String value) async {
    await (await _getInstance()).setString(key, value);
    return value;
  }

  static Future<Null> clearPrefs() async {
    (await _getInstance()).clear();
  }

  static Future<Map<String, dynamic>?> getMap(String key) async {
    try {
      final map = await getString(key);
      return map.isEmpty ? null : json.decode(map);
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> setMap(
      String key, Map<String, dynamic> value) async {
    await setString(key, json.encode(value));
    return value;
  }

  static Future<int?> getInt(String key) async {
    return (await _getInstance()).getInt(key);
  }

  static Future<int> setInt(String key, int value) async {
    await (await _getInstance()).setInt(key, value);
    return value;
  }

  static Future<bool?> getBool(String key) async {
    return (await _getInstance()).getBool(key);
  }

  static Future<bool?> containsKey(String key) async {
    return (await _getInstance()).containsKey(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    await (await _getInstance()).setBool(key, value);
    return value;
  }
}
