import 'package:pets_adventure_frontend/src/core/interface/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStorageService implements ILocalStorage {
  @override
  Future<void> delete(String key) async {
    final shared = await SharedPreferences.getInstance();
    await shared.remove(key);
  }

  @override
  Future<String?> get(String key) async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString(key);
  }

  @override
  Future<void> put(String key, dynamic value) async {
    final shared = await SharedPreferences.getInstance();
    if (value is bool) {
      await shared.setBool(key, value);
    } else if (value is String) {
      await shared.setString(key, value);
    } else if (value is int) {
      await shared.setInt(key, value);
    } else if (value is double) {
      await shared.setDouble(key, value);
    }
  }
}
