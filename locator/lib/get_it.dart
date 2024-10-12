import 'package:data/data_source/search_remote_data_source.dart';
import 'package:data/repository/search_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:remote/data_source/search_remote_data_source_impl.dart';
import 'package:remote/interceptor/header_interceptor.dart';
import 'package:remote/service/search_service.dart';

final locator = GetIt.instance;

initLocator() {
  _networkModule();
  _searchModule();
}

_networkModule() {
  BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );
  final dio = Dio(options)..interceptors.add(HeaderInterceptor());
  locator.registerLazySingleton(() => dio);
}

_searchModule() {
  locator.registerLazySingleton(() => SearchService(locator<Dio>()));
  locator.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(searchService: locator()),
  );
  locator.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(searchRemoteDataSource: locator()),
  );
  locator.registerLazySingleton(
    () => SearchImagesUseCase(searchRepository: locator()),
  );
}
