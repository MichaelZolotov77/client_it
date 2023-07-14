abstract class AuthRepository {
  //регистрация
  Future<dynamic> signUp({
    required String password,
    required String username,
    required String email,
  });

  //авторизация
  Future<dynamic> signIn({
    required String password,
    required String username,
  });

  //получение данных пользователя
  Future<dynamic> getProfile();

  //изменение данных username и email
  Future<dynamic> userUpdate({
    String? userName,
    String? email,
  });

  //изменение пароля
  Future<dynamic> passwordUpdate({
    required String oldPassword,
    required String newPassword,
  });

  //обновление токена
  Future<dynamic> refreshToken({required String refreshToken});
}
