import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_database_assignment/services/secure_storage_service.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));

    final secureStorage = SecureStorageService();
    final masterKey = await secureStorage.getData("master_key");

    if (masterKey != null) {
      context.go('/login');
    } else {
      context.go('/vault_setup');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.widthOf(context);
    final screenHeight = MediaQuery.heightOf(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 28),
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.45,
          height: screenHeight * 0.3,
          child: Image.asset("assets/images/combination_logo_white.png"),
        ),
      ),
    );
  }
}
