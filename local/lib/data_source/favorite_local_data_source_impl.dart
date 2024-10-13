import 'package:data/data_source/favorite_local_data_source.dart';
import 'package:data/model/favorite_image_entity.dart';
import 'package:local/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  @override
  Future<int> saveFavoriteImage({
    required FavoriteImageEntity favoriteImageEntity,
  }) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(
      favoriteImageTable,
      favoriteImageEntity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<FavoriteImageEntity>> getFavoriteImages() async {
    final db = await DatabaseHelper.instance.database;
    final queries = await db.query(favoriteImageTable);
    return queries
        .map((element) => FavoriteImageEntity.fromJson(element))
        .toList();
  }

  @override
  Future<int> removeFavoriteImage({required String imageId}) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      favoriteImageTable,
      where: 'imageId = ?',
      whereArgs: [imageId],
    );
  }
}
