import 'package:data/model/favorite_image_entity.dart';
import 'package:data/model/image_response.dart';
import 'package:data/model/meta_response.dart';
import 'package:data/model/paging_response.dart';
import 'package:domain/model/image_dto.dart';
import 'package:domain/model/meta_dto.dart';
import 'package:domain/model/paging_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FavoriteImageEntity mapper 테스트', () {
    // arrange
    final FavoriteImageEntity favoriteImageEntity = FavoriteImageEntity(
      imageId: 'https://tistory.com.jpg',
      imageUrl: 'https://tistory.com.jpg',
      displaySiteName: '티스토리',
      height: 100,
      width: 100,
    );

    // act
    final result = favoriteImageEntity.mapper();

    // assert
    expect(result, isA<ImageDto>());
  });

  test('ImageResponse mapper 테스트', () {
    // arrange
    final ImageResponse imageResponse = ImageResponse(
      collection: 'blog',
      thumbnailUrl: 'https://tistory.com.jpg',
      imageUrl: 'https://tistory.com.jpg',
      displaySiteName: '티스토리',
      docUrl: 'https://tistory.com',
      width: 100,
      height: 100,
      datetime: '2021-08-01',
    );

    // act
    final result = imageResponse.mapper();

    // assert
    expect(result, isA<ImageDto>());
  });

  test('MetaResponse mapper 테스트', () {
    // arrange
    final MetaResponse metaResponse = MetaResponse(
      isEnd: true,
      pageableCount: 1,
      totalCount: 1,
    );

    // act
    final result = metaResponse.mapper();

    // assert
    expect(result, isA<MetaDto>());
  });

  test('PagingResponse mapper 테스트', () {
    // arrange
    final PagingResponse<ImageResponse, ImageDto> pagingResponse =
        PagingResponse(
      metaResponse: MetaResponse(isEnd: true, pageableCount: 1, totalCount: 1),
      documentResponse: [
        ImageResponse(
          collection: 'blog',
          thumbnailUrl: 'https://tistory.com.jpg',
          imageUrl: 'https://tistory.com.jpg',
          displaySiteName: '티스토리',
          docUrl: 'https://tistory.com',
          width: 100,
          height: 100,
          datetime: '2021-08-01',
        ),
      ],
    );

    // act
    final result = pagingResponse.mapper();

    // assert
    expect(result, isA<PagingDto<ImageDto>>());
  });

  test('PagingResponse mapper 테스트', () {
    // arrange
    final PagingResponse<ImageResponse, ImageDto> pagingResponse =
        PagingResponse(
      metaResponse: MetaResponse(isEnd: true, pageableCount: 1, totalCount: 1),
      documentResponse: [
        ImageResponse(
          collection: 'blog',
          thumbnailUrl: 'https://tistory.com.jpg',
          imageUrl: 'https://tistory.com.jpg',
          displaySiteName: '티스토리',
          docUrl: 'https://tistory.com',
          width: 100,
          height: 100,
          datetime: '2021-08-01',
        ),
      ],
    );

    // act
    final result = pagingResponse.mapper();

    // assert
    expect(result, isA<PagingDto<ImageDto>>());
  });
}
