import 'package:client_it/feature/auth/domain/auth_repository.dart';
import 'package:client_it/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState.notAuthorized());

  final AuthRepository authRepository;

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity = await authRepository.signIn(
        password: password,
        username: username,
      );
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  void logOut() => emit(AuthState.notAuthorized());

  Future<void> signUp({
    required String username,
    required String password,
    required String email,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity = await authRepository.signUp(
        password: password,
        username: username,
        email: email,
      );
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState.fromJson(json);
    return state.whenOrNull(
      authorized: (userEntity) => AuthState.authorized(userEntity),
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(
              authorized: (userEntity) => AuthState.authorized(userEntity),
            )
            ?.toJson() ??
        AuthState.notAuthorized().toJson();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(AuthState.error(error));
    super.addError(error, stackTrace);
  }

  Future<void> refreshToken() async {
    final refreshToken =
        state.whenOrNull(authorized: (userEntity) => userEntity.refreshToken);
    try {
      final UserEntity userEntity =
          await authRepository.refreshToken(refreshToken: refreshToken);
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }
}


// 5.9 Реазизация глобального AuthCubit, который будет отвечать за авторизацию
// пользователя. Его задача заключается в том, чтобы отслеживать, в каком
// состоянии наш пользователь. Если пользователь деавторизуется, нажмет
// выйти, мы должны полностью перестроить интерфейс, и пребросить пользователя
// на экран авторизации и регистрации. Для этого используется flutter_bloc.
// part 'auth_state.dart' означает, что здесь есть часть AuthState.
// part 'auth_cubit.freezed.dart' необходимо указать, чтобы отработала
// кодогенерация. Как только мы созаем этот cubit, мы считаем что 
// не авторизованы.

//5.11 В конструкторе будем принимать AuthRepository. Здесь не используется
// какая-то конкретная реализация, а используется абстракция.

// 5.21 Будут сохраняться стейты только тогда, когда пользователь авторизован
