// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:client_it/app/data/dio_container.dart' as _i5;
import 'package:client_it/app/data/main_app_config.dart' as _i4;
import 'package:client_it/app/domain/app_config.dart' as _i3;
import 'package:client_it/feature/auth/data/network_auth_repository.dart'
    as _i7;
import 'package:client_it/feature/auth/domain/auth_repository.dart' as _i6;
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart'
    as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

const String _prod = 'prod';
const String _dev = 'dev';
const String _test = 'test';

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AppConfig>(
      _i4.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.singleton<_i3.AppConfig>(
      _i4.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i3.AppConfig>(
      _i4.TestAppConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i5.DioContainer>(_i5.DioContainer(gh<_i3.AppConfig>()));
    gh.factory<_i6.AuthRepository>(
        () => _i7.NetworkAuthRepository(gh<_i5.DioContainer>()));
    gh.singleton<_i8.AuthCubit>(_i8.AuthCubit(gh<_i6.AuthRepository>()));
    return this;
  }
}
