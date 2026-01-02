import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_downloader/core/config/global_keys.dart';
import 'package:spotify_downloader/core/utils/user_storage.dart';

/// Centralized authentication service for handling logout and navigation
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  /// Handles 401 unauthorized errors by logging out the user and redirecting to login
  Future<void> handleUnauthorized() async {
    try {
      // Clear user storage
      final userStorage = UserStorage();
      await userStorage.removeStorage();

      // Navigate to login screen
      final context = navigatorKey.currentContext;
      if (context != null && context.mounted) {
        GoRouter.of(context).go('/');
      }
    } catch (e) {
      debugPrint('Error handling unauthorized access: $e');
    }
  }

  /// Logs out the user and redirects to login screen
  Future<void> logout() async {
    try {
      // Clear user storage
      final userStorage = UserStorage();
      await userStorage.removeStorage();

      // Navigate to login screen
      final context = navigatorKey.currentContext;
      if (context != null && context.mounted) {
        GoRouter.of(context).go('/');
      }
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
  }

  /// Checks if user is authenticated by checking if token exists
  Future<bool> isAuthenticated() async {
    try {
      final userStorage = UserStorage();
      final token = await userStorage.jwtOrEmpty;
      return token.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking authentication status: $e');
      return false;
    }
  }
}
