abstract class ILocalStorage {
  Future<dynamic> get(String key);
  Future<dynamic> delete(String key);
  Future<dynamic> put(String key, dynamic value);
}
