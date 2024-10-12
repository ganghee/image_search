import 'package:domain/domain.dart';
import 'package:domain/model/image_dto.dart';
import 'package:domain/model/paging_dto.dart';

class SearchImagesUseCase {
  final SearchRepository _searchRepository;

  SearchImagesUseCase({
    required SearchRepository searchRepository,
  }) : _searchRepository = searchRepository;

  Future<PagingDto<ImageDto>> call({
    required String query,
    required int page,
  }) async {
    return await _searchRepository.searchImages(query: query, page: page);
  }
}
