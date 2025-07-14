import 'package:insurance_seguradora/app/app_routes.dart';
import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:insurance_seguradora/domain/viewmodels/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService;

  LoginViewModel(this._authService);

  String? errorMessage;
  bool isLoading = false;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final user = await _authService.login(email, password);

      if (user != null) {
        Provider.of<SessionViewModel>(context, listen: false).setUser(user);
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        errorMessage = 'Login inválido. Verifique suas credenciais.';
      }
    } catch (e) {
      errorMessage = 'Erro ao fazer login';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void goToRegisterPage({required BuildContext context}) {
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }
}
