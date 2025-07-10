import 'package:flutter_tractian/features/data/data_source/assets_tree_data_source.dart';
import 'package:flutter_tractian/features/data/repositories/assets_tree_repository_impl.dart';
import 'package:flutter_tractian/features/domain/repositories/assets_tree_repository.dart';
import 'package:flutter_tractian/features/domain/usecases/fetch_all_companies_assets_use_case.dart';
import 'package:flutter_tractian/features/domain/usecases/fetch_all_companies_locations_use_case.dart';
import 'package:flutter_tractian/features/domain/usecases/fetch_all_companies_use_case.dart';
import 'package:flutter_tractian/features/presentation/controllers/home_controller.dart';
import 'package:flutter_tractian/features/presentation/controllers/assets_tree_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

void init() {
  // Dio singleton
  Dio dio = Dio();

  // DataSource
  getIt.registerLazySingleton<AssetsTreeDataSource>(
    () => AssetsTreeDataSource(dio),
  );

  // Repository
  getIt.registerLazySingleton<AssetsTreeRepository>(
    () => AssetsTreeRepositoryImpl(getIt()),
  );

  // UseCases
  getIt.registerLazySingleton(() => FetchAllCompaniesUseCase(getIt()));
  getIt.registerLazySingleton(() => FetchAllCompaniesAssetsUseCase(getIt()));
  getIt.registerLazySingleton(() => FetchAllCompaniesLocationsUseCase(getIt()));

  // Controllers

  getIt.registerLazySingleton<HomeController>(
    () => HomeController(getIt<FetchAllCompaniesUseCase>()),
  );

  getIt.registerLazySingleton<AssetsTreeController>(
    () => AssetsTreeController(
      getIt<FetchAllCompaniesAssetsUseCase>(),
      getIt<FetchAllCompaniesLocationsUseCase>(),
    ),
  );
}
