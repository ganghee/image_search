import 'package:data/model/favorite_image_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local/data_source/favorite_local_data_source_impl.dart';
import 'package:local/db/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database database;
  late FavoriteLocalDataSourceImpl favoriteLocalDataSourceImpl;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
      CREATE TABLE $favoriteImageTable(
        imageId TEXT PRIMARY KEY,
        imageUrl TEXT,
        displaySiteName TEXT,
        height INTEGER,
        width INTEGER
      )
      ''');
        },
      ),
    );
    favoriteLocalDataSourceImpl = FavoriteLocalDataSourceImpl(database);
  });

  test(
    'Database에 FavoriteImageEntity를 저장하면 해당 데이터가 저장되어야 한다.',
    () async {
      // arrange
      final FavoriteImageEntity favoriteImageEntity = FavoriteImageEntity(
        imageId: '1',
        imageUrl: 'https://image.com',
        displaySiteName: 'site',
        height: 100,
        width: 100,
      );

      // act
      await favoriteLocalDataSourceImpl.saveFavoriteImage(
        favoriteImageEntity: favoriteImageEntity,
      );

      // assert
      final result = await favoriteLocalDataSourceImpl.getFavoriteImages();
      expect(result, [favoriteImageEntity]);
    },
  );

  test(
    'Database에 저장된 FavoriteImageEntity를 삭제하면 해당 데이터가 삭제되어야 한다.',
    () async {
      // arrange
      final FavoriteImageEntity favoriteImageEntity = FavoriteImageEntity(
        imageId: '1',
        imageUrl: 'https://image.com',
        displaySiteName: 'site',
        height: 100,
        width: 100,
      );
      await favoriteLocalDataSourceImpl.saveFavoriteImage(
        favoriteImageEntity: favoriteImageEntity,
      );

      // act
      await favoriteLocalDataSourceImpl.removeFavoriteImage(
        imageId: favoriteImageEntity.imageId,
      );

      // assert
      final result = await favoriteLocalDataSourceImpl.getFavoriteImages();
      expect(result, []);
    },
  );

  tearDown(() async {
    await database.close();
  });
}
