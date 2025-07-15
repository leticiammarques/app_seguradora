import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:insurance_seguradora/data/models/user_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService;

  LoginViewModel(this._authService);

  String? errorMessage;
  bool isLoading = false;
  UserModel? user;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      user = await _authService.login(email, password);

      if (user == null) {
        errorMessage = 'Login inválido. Verifique suas credenciais.';
      }
    } catch (e) {
      errorMessage = 'Erro ao fazer login';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleObscurePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }
}
