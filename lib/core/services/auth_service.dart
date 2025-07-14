import 'package:insurance_seguradora/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserModel?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;

      if (user != null) {
        Map<String, dynamic> doc = {
          'id': user.uid,
          'name': user.displayName,
          'email': user.email,
          'phone': user.phoneNumber,
        };
        return UserModel.fromMap(doc);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> register(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Usuário criado no Firebase Auth: ${userCredential.user?.uid}');

      await userCredential.user?.updateDisplayName(name);
      print('Nome de exibição atualizado.');

      final userModel = UserModel(
        id: userCredential.user?.uid,
        name: name,
        email: email,
        phone: phone,
      );


      return userModel;
    } on FirebaseAuthException catch (e) {
      print('AuthService - Erro de autenticação: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      print('AuthService - Erro geral: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Stream<User?> get userChanges {
    return _auth.authStateChanges();
  }
}
