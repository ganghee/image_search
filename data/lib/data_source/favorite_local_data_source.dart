import 'package:data/model/favorite_image_entity.dart';

abstract class FavoriteLocalDataSource {
  Future<int> saveFavoriteImage({
    required FavoriteImageEntity favoriteImageEntity,
  });

  Future<void> removeFavoriteImage({
    required String imageId,
  });

  Future<List<FavoriteImageEntity>> getFavoriteImages();
}
