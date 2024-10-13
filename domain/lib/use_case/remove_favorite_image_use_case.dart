import 'package:domain/domain.dart';

class RemoveFavoriteImageUseCase {
  final SearchRepository _searchRepository;

  RemoveFavoriteImageUseCase({
    required SearchRepository searchRepository,
  }) : _searchRepository = searchRepository;

  Future<void> call({required String imageId}) =>
      _searchRepository.removeFavoriteImage(imageId: imageId);
}
