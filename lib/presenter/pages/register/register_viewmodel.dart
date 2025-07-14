import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:insurance_seguradora/data/models/user_model.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService;

  RegisterViewModel(this._authService);

  String? errorMessage;
  bool isLoading = false;
  UserModel? user;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      user = await _authService.register(email, password, name, phone);
      if (user == null) {
        errorMessage = 'Erro ao criar usuário';
      }
    } catch (e) {
      errorMessage = 'Erro: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
