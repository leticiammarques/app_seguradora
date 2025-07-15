import 'package:insurance_seguradora/data/local/user_local_storage_service.dart';
import 'package:insurance_seguradora/data/models/user_model.dart';
import 'package:flutter/material.dart';

class SessionViewModel extends ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  void setUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    UserLocalStorageService().clearCurrentSession();
    notifyListeners();
  }

  bool get isLoggedIn => _currentUser != null;
}
