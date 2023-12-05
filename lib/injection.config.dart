// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app/article/presentation/controllers/article_details_cubit.dart' as _i3;
import 'app/article/presentation/controllers/article_list_cubit.dart' as _i4;
import 'core/services/http_service.dart' as _i5;
import 'core/services/navigation_service.dart' as _i6;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.ArticleDetailsCubit>(() => _i3.ArticleDetailsCubit());
  gh.factory<_i4.ArticleListCubit>(() => _i4.ArticleListCubit());
  gh.lazySingleton<_i5.HttpService>(() => _i5.HttpService());
  gh.lazySingleton<_i6.NavigationService>(() => _i6.NavigationService());
  return getIt;
}
