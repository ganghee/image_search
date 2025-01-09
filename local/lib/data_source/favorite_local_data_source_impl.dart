import 'package:data/data_source/favorite_local_data_source.dart';
import 'package:data/model/favorite_image_entity.dart';
import 'package:local/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final Database? _database;

  FavoriteLocalDataSourceImpl([Database? database]) : _database = database;

  @override
  Future<int> saveFavoriteImage({
    required FavoriteImageEntity favoriteImageEntity,
  }) async {
    return await (_database ?? await DatabaseHelper.instance.database).insert(
      favoriteImageTable,
      favoriteImageEntity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<FavoriteImageEntity>> getFavoriteImages() async {
    final queries = await (_database ?? await DatabaseHelper.instance.database)
        .query(favoriteImageTable);
    return queries
        .map((element) => FavoriteImageEntity.fromJson(element))
        .toList();
  }

  @override
  Future<int> removeFavoriteImage({required String imageId}) async {
    return await (_database ?? await DatabaseHelper.instance.database).delete(
      favoriteImageTable,
      where: 'imageId = ?',
      whereArgs: [imageId],
    );
  }
}
