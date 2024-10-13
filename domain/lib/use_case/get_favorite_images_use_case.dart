import 'package:domain/domain.dart';
import 'package:domain/model/image_dto.dart';

class GetFavoriteImagesUseCase {
  final SearchRepository _searchRepository;

  GetFavoriteImagesUseCase({
    required SearchRepository searchRepository,
  }) : _searchRepository = searchRepository;

  Future<List<ImageDto>> call() => _searchRepository.getFavoriteImages();
}
