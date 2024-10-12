import 'package:data/data_source/search_remote_data_source.dart';
import 'package:domain/model/image_dto.dart';
import 'package:domain/model/paging_dto.dart';
import 'package:domain/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource _searchRemoteDataSource;

  SearchRepositoryImpl({
    required SearchRemoteDataSource searchRemoteDataSource,
  }) : _searchRemoteDataSource = searchRemoteDataSource;

  @override
  Future<PagingDto<ImageDto>> searchImages({
    required String query,
    required int page,
  }) async =>
      await _searchRemoteDataSource.searchImages(
        query: query,
        page: page,
      );
}
