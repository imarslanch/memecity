import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String _keySplashShown = 'splash_shown';
  static const String _keySignInShown = 'sign_in_shown';
  static const String _keyBiometricEnabled = 'biometrics_enabled';

  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyBiometricEnabled) ?? false;
  }

  Future<void> setBiometricEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyBiometricEnabled, value);
  }

  Future<bool> isSplashShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySplashShown) ?? false;
  }

  Future<void> setSplashShown(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySplashShown, value);
  }

  Future<bool> isSignInShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySignInShown) ?? false;
  }

  Future<void> setSignInShown(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySignInShown, value);
  }
}
