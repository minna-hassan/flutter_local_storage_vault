import 'package:go_router/go_router.dart';
import 'package:flutter_database_assignment/screens/custom_splash_screen.dart';
import 'package:flutter_database_assignment/screens/vault_setup_screen.dart';
import 'package:flutter_database_assignment/screens/home_screen.dart';
import 'package:flutter_database_assignment/screens/setting_screen.dart';
import 'package:flutter_database_assignment/screens/unlock_vault_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => CustomSplashScreen()),
    GoRoute(
      path: '/vault_setup',
      builder: (context, state) => VaultSetupScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
    GoRoute(path: '/login', builder: (context, state) => UnlockVaultScreen()),
  ],
);
