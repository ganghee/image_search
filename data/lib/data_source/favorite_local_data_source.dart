import 'package:data/model/favorite_image_entity.dart';
import 'package:domain/model/image_dto.dart';

abstract class FavoriteLocalDataSource {
  Future<void> saveFavoriteImage({
    required FavoriteImageEntity favoriteImageEntity,
  });

  Future<void> removeFavoriteImage({
    required ImageDto imageDto,
  });

  Future<List<FavoriteImageEntity>> getFavoriteImages();
}
