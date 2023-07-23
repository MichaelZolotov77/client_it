import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String email,
    required String username,
    required String id,
    String? accessToken,
    String? refreshToken,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}


// Модель, которая описывает нашего пользователя.
// 5.6 Part означает, что это часть файла, который будет сгенерирован.
// Этот сгенерированный файл описывает нашего пользователя. Если бы мы хотели
// сделать хорошую иммутабельную(неизменяемую) модель, что пришлось бы 
// делать вручную.