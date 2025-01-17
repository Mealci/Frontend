import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManagement {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> writeData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readData(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAllData() async {
    await _secureStorage.deleteAll();
  }

  Future<Map<String, String>> readAllData() async {
    return await _secureStorage.readAll();
  }
}
