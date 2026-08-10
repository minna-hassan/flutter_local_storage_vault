import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Future<void> saveData(String key, String data) async {
    await storage.write(key: key, value: data);
  }

  Future<String?> getData(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteData(String key) async {
    await storage.delete(key: key);
  }
}
