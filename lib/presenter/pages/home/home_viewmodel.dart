import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:insurance_seguradora/domain/viewmodels/session_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthService authService;
  final SessionViewModel session;

  HomeViewModel({required this.authService, required this.session,});

  bool isLoading = false;

  Future<void> logout(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await authService.logout();
    } catch (e) {
      isLoading = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
