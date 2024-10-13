import 'package:domain/domain.dart';
import 'package:domain/model/image_dto.dart';
import 'package:domain/model/paging_dto.dart';

class SearchImagesUseCase {
  final SearchRepository _searchRepository;
  final GetFavoriteImagesUseCase _getFavoriteImagesUseCase;

  SearchImagesUseCase({
    required SearchRepository searchRepository,
    required GetFavoriteImagesUseCase getFavoriteImagesUseCase,
  })  : _searchRepository = searchRepository,
        _getFavoriteImagesUseCase = getFavoriteImagesUseCase;

  Future<PagingDto<ImageDto>> call({
    required String query,
    required int page,
  }) async {
    return await _searchRepository
        .searchImages(query: query, page: page)
        .then((paging) async {
      final List<ImageDto> favoriteImages = await _getFavoriteImagesUseCase();
      final updateFavoriteImages = paging.documents.map((searchedImageDto) {
        if (favoriteImages.any((favoriteImage) =>
            favoriteImage.imageUrl == searchedImageDto.imageUrl)) {
          return searchedImageDto.copyWith(isFavorite: true);
        } else {
          return searchedImageDto;
        }
      }).toList();
      return paging.copyWith(documents: updateFavoriteImages);
    });
  }
}
