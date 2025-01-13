import 'dart:convert';

import 'package:data/model/image_response.dart';
import 'package:data/model/paging_response.dart';
import 'package:domain/model/image_dto.dart';
import 'package:domain/model/paging_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/service/search_service.dart';

import 'fixtures/fixture_reader.dart';

class MockSearchService extends Mock implements SearchService {}

void main() {
  late MockSearchService mockSearchService;
  const query = 'cat';
  const page = 1;
  const size = 10;

  setUp(() {
    mockSearchService = MockSearchService();
  });

  group(('SearchService API 테스트'), () {
    test('검색 요청 테스트', () async {
      // arrange
      final String emptyBody = fixture('empty_body.json');
      final Map<String, dynamic> emptyBodyMap = json.decode(emptyBody);
      final PagingResponse<ImageResponse, ImageDto> response =
          PagingResponse.fromJson(
        emptyBodyMap,
        (json) => ImageResponse.fromJson(json as Map<String, dynamic>),
        (json) => ImageDto.fromJson(json as Map<String, dynamic>),
      );
      when(() => mockSearchService.searchImages(
            query: query,
            page: page,
            size: size,
          )).thenAnswer((_) async => response);

      // act
      await mockSearchService.searchImages(
        query: query,
        page: page,
        size: size,
      );

      // assert
      verify(
        () => mockSearchService.searchImages(
          query: query,
          page: page,
          size: size,
        ),
      );
    });

    test('빈 response 테스트', () async {
      // arrange
      final String emptyBody = fixture('empty_body.json');
      final Map<String, dynamic> emptyBodyMap = json.decode(emptyBody);
      final PagingResponse<ImageResponse, ImageDto> response =
          PagingResponse.fromJson(
        emptyBodyMap,
        (json) => ImageResponse.fromJson(json as Map<String, dynamic>),
        (json) => ImageDto.fromJson(json as Map<String, dynamic>),
      );
      when(() => mockSearchService.searchImages(
            query: query,
            page: page,
            size: size,
          )).thenAnswer((_) async => response);

      // act
      final PagingResponse<ImageResponse, ImageDto> result =
          await mockSearchService.searchImages(
        query: query,
        page: page,
        size: size,
      );

      // assert
      expect(
        result,
        isA<PagingResponse<ImageResponse, ImageDto>>().having(
          (pagingResponse) => pagingResponse.documentResponse.isEmpty,
          'empty documents',
          true,
        ),
      );
    });

    test('유효한 값이 있는 response 테스트', () async {
      // arrange
      final String searchBody = fixture('search_valid_body.json');
      final Map<String, dynamic> emptyBodyMap = json.decode(searchBody);
      final PagingResponse<ImageResponse, ImageDto> response =
          PagingResponse.fromJson(
        emptyBodyMap,
        (json) => ImageResponse.fromJson(json as Map<String, dynamic>),
        (json) => ImageDto.fromJson(json as Map<String, dynamic>),
      );
      when(() => mockSearchService.searchImages(
            query: query,
            page: page,
            size: size,
          )).thenAnswer((_) async => response);

      // act
      final PagingResponse<ImageResponse, ImageDto> result =
          await mockSearchService.searchImages(
        query: query,
        page: page,
        size: size,
      );

      // assert
      expect(result, response);
    });
  });

  group(('SearchService mapper 테스트'), () {
    test(
        'PagingResponse<ImageResponse, ImageDto>타입이 주어졌을 때 mapper() 확장함수 적용시 PagingDto<ImageDto> 타입 반환',
        () {
      // arrange
      final String searchBody = fixture('search_valid_body.json');
      final Map<String, dynamic> emptyBodyMap = json.decode(searchBody);
      final PagingResponse<ImageResponse, ImageDto> response =
          PagingResponse.fromJson(
        emptyBodyMap,
        (json) => ImageResponse.fromJson(json as Map<String, dynamic>),
        (json) => ImageDto.fromJson(json as Map<String, dynamic>),
      );

      // act
      final result = response.mapper();

      // assert
      expect(result, isA<PagingDto<ImageDto>>());
    });
  });
}
