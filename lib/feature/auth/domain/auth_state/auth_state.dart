part of 'auth_cubit.dart';

//состояния
@freezed
class AuthState with _$AuthState {
  factory AuthState.notAuthorized() = _AuthStateNotAuthorized;

  factory AuthState.authorized(UserEntity userEntity) = _AuthStateAuthorized;

  factory AuthState.waiting() = _AuthStateWaiting;

  factory AuthState.error(dynamic error) = _AuthStateError;
}


//5.9 Для того, чтобы указать, что наш AuthState является частью AuthCubit,
// пишем part of 'auth_cubit.dart'.
