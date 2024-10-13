import 'package:domain/domain.dart';
import 'package:domain/model/image_dto.dart';

class SaveFavoriteImageUseCase {
  final SearchRepository _searchRepository;

  SaveFavoriteImageUseCase({
    required SearchRepository searchRepository,
  }) : _searchRepository = searchRepository;

  Future<void> call({
    required ImageDto imageDto,
  }) =>
      _searchRepository.saveFavoriteImage(imageDto: imageDto);
}
