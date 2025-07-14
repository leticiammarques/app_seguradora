import 'package:insurance_seguradora/app/app_routes.dart';
import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService;

  RegisterViewModel(this._authService);

  String? errorMessage;
  bool isLoading = false;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final user = await _authService.register(email, password, name, phone);
      if (user == null) {
        errorMessage = 'Erro ao criar usuário';
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } catch (e) {
      errorMessage = 'Erro: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
