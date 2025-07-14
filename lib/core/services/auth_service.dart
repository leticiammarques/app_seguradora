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
        await user.reload();

        final userModel = UserModel(
          id: user.uid,
          name: user.displayName,
          email: user.email,
          phone: user.phoneNumber,
        );
        return userModel;
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
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);

      final userModel = UserModel(
        id: userCredential.user?.uid,
        name: name,
        email: email,
        phone: phone,
      );

      return userModel;
    } on FirebaseAuthException catch (_) {
      return null;
    } catch (e) {
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
