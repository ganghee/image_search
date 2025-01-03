import 'package:data/data_source/favorite_local_data_source.dart';
import 'package:data/data_source/search_remote_data_source.dart';
import 'package:data/mapper/data_to_domain_mapper.dart';
import 'package:data/model/favorite_image_entity.dart';
import 'package:domain/model/image_dto.dart';
import 'package:domain/model/paging_dto.dart';
import 'package:domain/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource _searchRemoteDataSource;
  final FavoriteLocalDataSource _imageLocalDataSource;

  SearchRepositoryImpl({
    required SearchRemoteDataSource searchRemoteDataSource,
    required FavoriteLocalDataSource imageLocalDataSource,
  })  : _searchRemoteDataSource = searchRemoteDataSource,
        _imageLocalDataSource = imageLocalDataSource;

  @override
  Future<PagingDto<ImageDto>> searchImages({
    required String query,
    required int page,
  }) =>
      _searchRemoteDataSource.searchImages(
        query: query,
        page: page,
      );

  @override
  Future<void> saveFavoriteImage({
    required ImageDto imageDto,
  }) =>
      _imageLocalDataSource.saveFavoriteImage(
        favoriteImageEntity: imageDto.toEntity(),
      );

  @override
  Future<List<ImageDto>> getFavoriteImages() async {
    final favoriteImages = await _imageLocalDataSource.getFavoriteImages();
    return favoriteImages.mapper();
  }

  @override
  Future<void> removeFavoriteImage({required String imageId}) =>
      _imageLocalDataSource.removeFavoriteImage(imageId: imageId);
}
