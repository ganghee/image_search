import 'package:data/data_source/search_remote_data_source.dart';
import 'package:domain/model/image_dto.dart';
import 'package:domain/model/paging_dto.dart';
import 'package:remote/service/search_service.dart';

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final SearchService _searchService;

  SearchRemoteDataSourceImpl({required SearchService searchService})
      : _searchService = searchService;

  @override
  Future<PagingDto<ImageDto>> searchImages({
    required String query,
    required int page,
  }) async =>
      await _searchService
          .searchImages(
            query: query,
            page: page,
            size: 30,
          )
          .then((pagingResponse) => pagingResponse.mapper());
}
