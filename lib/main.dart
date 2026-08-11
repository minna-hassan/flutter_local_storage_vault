import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_database_assignment/routes/go_router.dart';
import 'package:flutter_database_assignment/services/hive_service.dart';
import 'package:flutter_database_assignment/services/secure_storage_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await HiveService.init();

  final secureStorage = SecureStorageService();
  final masterKey = await secureStorage.getData("master_key");
  final initialRoute = masterKey != null ? '/login' : '/vault_setup';

  FlutterNativeSplash.remove();
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Secure Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      routerConfig: getRouter(initialRoute),
    );
  }
}
