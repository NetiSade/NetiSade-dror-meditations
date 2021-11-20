import 'package:dror_meditations/services/auth_service.dart';
import 'package:flutter/widgets.dart';

class AuthProvider with ChangeNotifier {
  final _authService = AuthService();

  bool get isLoggedIn => _authService.isLoggedIn;

  AuthProvider() {
    init();
  }

  void init() {
    _authService.init(onAuthStateChanges);
  }

  void onAuthStateChanges() {
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    try {
      _authService.register(email, password);
    } catch (e) {
      print('register failed! | $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _authService.signIn(email, password);
    } catch (e) {
      print('signIn failed! | $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      print('signOut error | $e');
    }
  }
}
