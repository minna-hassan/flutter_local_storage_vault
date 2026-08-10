import 'package:shared_preferences/shared_preferences.dart';

class SharedprefService {
  static Future<void> saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", isLoggedIn);
  }

  static Future<bool> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }

  static Future<void> saveNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
  }

  static Future<bool> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notificationsEnabled') ?? true;
  }

  static Future<void> saveAutoLockTime(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('autoLockTime', value);
  }

  static Future<String> getAutoLockTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('autoLockTime') ?? 'Immediately';
  }

  static Future<void> saveBiometric(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricEnabled', value);
  }

  static Future<bool> getBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometricEnabled') ?? false;
  }

  static Future<void> saveName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', value);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
  }

  static Future<void> saveEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', value);
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail') ?? 'user@example.com';
  }

  static Future<void> saveAppearance(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appAppearance', value);
  }

  static Future<String> getAppearance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('appAppearance') ?? 'System Default';
  }
}
