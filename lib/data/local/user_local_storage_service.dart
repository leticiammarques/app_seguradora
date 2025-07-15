import 'package:hive/hive.dart';
import 'package:insurance_seguradora/data/models/user_model.dart';

class UserLocalStorageService {
  static const String _boxName = 'userBox';

  /// Salva os dados do usuário no Hive, usando o UID como chave.
  Future<void> saveUser(UserModel user) async {
    final box = Hive.box(_boxName);

    final userMap = {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
    };

    await box.put(user.id, userMap);
    await box.put('lastLoggedUserId', user.id);
  }

  /// Retorna o usuário atualmente logado com base no último UID salvo.
  UserModel? getCurrentUser() {
    final box = Hive.box(_boxName);
    final uid = box.get('lastLoggedUserId');
    if (uid == null) return null;

    final userMap = box.get(uid);
    if (userMap == null) return null;

    return UserModel(
      id: userMap['id'],
      name: userMap['name'],
      email: userMap['email'],
      phone: userMap['phone'],
    );
  }

  /// Retorna os dados de um usuário pelo UID.
  UserModel? getUserById(String uid) {
    final box = Hive.box(_boxName);
    final userMap = box.get(uid);
    if (userMap == null) return null;

    return UserModel(
      id: userMap['id'],
      name: userMap['name'],
      email: userMap['email'],
      phone: userMap['phone'],
    );
  }

  /// Limpa somente a referência do usuário logado (mantém os dados).
  Future<void> clearCurrentSession() async {
    final box = Hive.box(_boxName);
    await box.delete('lastLoggedUserId');
  }

  /// Limpa completamente os dados de um usuário (pode ser chamado no logout se necessário).
  Future<void> deleteUserData(String uid) async {
    final box = Hive.box(_boxName);
    await box.delete(uid);
  }
}
