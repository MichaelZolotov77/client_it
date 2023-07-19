import 'package:client_it/feature/auth/domain/auth_repository.dart';
import 'package:client_it/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState.notAuthorized());

  final AuthRepository authRepository;
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
