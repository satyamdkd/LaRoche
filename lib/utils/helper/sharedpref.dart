import "package:flutter/foundation.dart";
import "package:get_storage/get_storage.dart";

/// ***********************************************************
/// ******************** SHARED PREF CLASS ********************
/// ***********************************************************

class StorageUtil {
  StorageUtil(this._storage);

  final GetStorage _storage;

  static StorageUtil? _instance;

  static Future<void> init() async {
    await GetStorage.init();

    if (_instance == null) {
      final GetStorage storage = GetStorage();
      _instance = StorageUtil(storage);
    }
  }

  static Future<void> write(String key, dynamic value) async {
    _instance!._storage.write(key, value);
  }

  static T? read<T>(String key, [T? defaultValue]) {
    return (_instance!._storage.read(key) as T?) ?? defaultValue;
  }

  static Future<void> clearKey(String key) async {
    _instance!._storage.remove(key);
  }

  static Future<void> clearAll() async {
    _instance!._storage.erase();
  }
}

abstract class Keys {
  static const String _userDetails = "user_details";
}

class SharedPref {

  /// ********************************************************
  /// ******************** User Details **********************
  /// ********************************************************

  static Future<void> saveUserDetails(Map<String, dynamic>? user) async {
    await StorageUtil.write(Keys._userDetails, user);
    debugPrint("DATA SAVED!!");
  }

  static Map<String, dynamic>? getUserDetails() {
    var user = StorageUtil.read(Keys._userDetails);
    return user;
  }

  static Future removeUserDetails() async {
    await StorageUtil.clearKey(Keys._userDetails);
  }

  /// ********************************************************
  /// ******************** Token *****************************
  /// ********************************************************

  static String? getToken() {
    var user = getUserDetails();
    if (user == null || user['data'] == null) {
      return null;
    }
    return user['data']['token'];
  }
}
