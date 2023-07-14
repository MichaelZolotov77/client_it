// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBuildar extends StatelessWidget {
  const AuthBuildar({
    Key? key,
    required this.isNotAutorized,
    required this.isWaiting,
    required this.isAuthorized,
  }) : super(key: key);

  final WidgetBuilder isNotAutorized;
  final WidgetBuilder isWaiting;
  final ValueWidgetBuilder isAuthorized;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.when(
          notAuthorized: () => isNotAutorized(context),
          authorized: (userEntity) => isAuthorized(context, userEntity, this),
          waiting: () => isWaiting(context),
          error: (error) => isNotAutorized(context),
        );
      },
      listenWhen: (previous, current) =>
          previous.mapOrNull(
            error: (value) => value,
          ) !=
          current.mapOrNull(error: (value) => value),
      listener: (context, state) {
        state.whenOrNull(
          error: (error) => _showSkackBar,
        );
      },
    );
  }

  void _showSkackBar(BuildContext context, dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(
            maxLines: 5,
            error.toString(),
          ),
        ),
      ),
    );
  }
}
