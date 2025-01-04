import 'package:bloc_test/bloc_test.dart';
import 'package:domain/use_case/get_favorite_images_use_case.dart';
import 'package:domain/use_case/remove_favorite_image_use_case.dart';
import 'package:domain/use_case/save_favorite_image_use_case.dart';
import 'package:domain/use_case/search_images_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/bloc/search_bloc.dart';

import 'paging_dummy.dart';

class MockSearchImagesUseCase extends Mock implements SearchImagesUseCase {}

class MockGetFavoriteImagesUseCase extends Mock
    implements GetFavoriteImagesUseCase {}

class MockSaveFavoriteImageUseCase extends Mock
    implements SaveFavoriteImageUseCase {}

class MockRemoveFavoriteImageUseCase extends Mock
    implements RemoveFavoriteImageUseCase {}

void main() {
  late SearchBloc searchBloc;
  late SearchImagesUseCase searchImagesUseCase;
  late GetFavoriteImagesUseCase getFavoriteImagesUseCase;
  late SaveFavoriteImageUseCase saveFavoriteImageUseCase;
  late RemoveFavoriteImageUseCase removeFavoriteImageUseCase;

  setUp(() {
    searchImagesUseCase = MockSearchImagesUseCase();
    getFavoriteImagesUseCase = MockGetFavoriteImagesUseCase();
    saveFavoriteImageUseCase = MockSaveFavoriteImageUseCase();
    removeFavoriteImageUseCase = MockRemoveFavoriteImageUseCase();
    searchBloc = SearchBloc(
      searchImagesUseCase,
      getFavoriteImagesUseCase,
      saveFavoriteImageUseCase,
      removeFavoriteImageUseCase,
    );
  });

  blocTest(
    '초기 상태에 SearchImagesEvent 이벤트가 들어왔을 때 loading -> success 상태 확인',
    build: () => searchBloc,
    setUp: () {
      when(
        () => searchImagesUseCase(
          query: 'cat',
          page: 1,
        ),
      ).thenAnswer((_) => Future.value(imagePagingDtoDummy));
    },
    act: (bloc) => bloc.add((SearchImagesEvent(isRefresh: true, query: 'cat'))),
    expect: () => [
      SearchState(
        searchStatus: LoadingSearchStatus(),
        query: '',
        favoriteImages: List.empty(),
      ),
      SearchState(
        searchStatus: SuccessSearchStatus(
          imagePagingVo: imagePagingVoDummy,
        ),
        query: 'cat',
        favoriteImages: List.empty(),
      ),
    ],
  );

  blocTest(
    '기존 리스트가 있는 상태에서 SearchImagesEvent 이벤트가 들어왔을 때 loading -> success 상태 확인',
    build: () => searchBloc,
    setUp: () {
      when(
        () => searchImagesUseCase(
          query: 'cat',
          page: 1,
        ),
      ).thenAnswer((_) => Future.value(imagePagingDtoDummy));
    },
    seed: () => SearchState(
      searchStatus: SuccessSearchStatus(
        imagePagingVo: imagePagingVoDummy,
      ),
      query: 'cat',
      favoriteImages: List.empty(),
    ),
    act: (bloc) => bloc.add(SearchImagesEvent(isRefresh: true)),
    expect: () => [
      SearchState(
        searchStatus: LoadingSearchStatus(),
        query: 'cat',
        favoriteImages: List.empty(),
      ),
      SearchState(
        searchStatus: SuccessSearchStatus(
          imagePagingVo: imagePagingVoDummy,
        ),
        query: 'cat',
        favoriteImages: List.empty(),
      ),
    ],
  );

  blocTest(
    '기존 리스트가 있는 상태에서 UpdateFavoriteEvent 이벤트가 들어왔을 때(isFavorite = true) 즐겨찾기 업데이트 확인',
    build: () => searchBloc,
    setUp: () {
      when(
        () => saveFavoriteImageUseCase(imageDto: imageDtoDummy),
      ).thenAnswer((_) async => Future.value());
    },
    seed: () => SearchState(
      searchStatus: SuccessSearchStatus(
        imagePagingVo: imagePagingVoDummy,
      ),
      query: '',
      favoriteImages: List.empty(),
    ),
    act: (bloc) => bloc.add(UpdateFavoriteEvent(imageVo: imageVoDummy)),
    expect: () => [
      SearchState(
        searchStatus: SuccessSearchStatus(
          imagePagingVo: imagePagingVoDummy.copyWith(
            items: imagePagingVoDummy.items.map((imageVo) {
              if (imageVo == imageVoDummy) {
                return imageVoDummy.copyWith(isFavorite: true);
              }
              return imageVo;
            }).toList(),
          ),
        ),
        query: '',
        favoriteImages: [imageVoDummy.copyWith(isFavorite: true)],
      ),
    ],
  );

  blocTest(
    '기존 리스트가 있는 상태에서 UpdateFavoriteEvent 이벤트가 들어왔을 때(isFavorite = false) 즐겨찾기 업데이트 확인',
    build: () => searchBloc,
    setUp: () {
      when(
        () => saveFavoriteImageUseCase(imageDto: imageDtoDummy),
      ).thenAnswer((_) async => Future.value());
    },
    seed: () => SearchState(
      searchStatus: SuccessSearchStatus(
        imagePagingVo: imagePagingVoDummy.copyWith(
          items: imagePagingVoDummy.items.map((imageVo) {
            if (imageVo == imageVoDummy) {
              return imageVoDummy.copyWith(isFavorite: true);
            }
            return imageVo;
          }).toList(),
        ),
      ),
      query: '',
      favoriteImages: [imageVoDummy.copyWith(isFavorite: true)],
    ),
    act: (bloc) => bloc.add(
      UpdateFavoriteEvent(imageVo: imageVoDummy.copyWith(isFavorite: true)),
    ),
    expect: () => [
      SearchState(
        searchStatus: SuccessSearchStatus(
          imagePagingVo: imagePagingVoDummy.copyWith(
            items: imagePagingVoDummy.items.map((imageVo) {
              if (imageVo == imageVoDummy) {
                return imageVoDummy.copyWith(isFavorite: false);
              }
              return imageVo;
            }).toList(),
          ),
        ),
        query: '',
        favoriteImages: List.empty(),
      ),
    ],
  );

  blocTest(
    '저장된 즐겨 찾기 리스트 확인',
    build: () => searchBloc,
    setUp: () {
      when(() => getFavoriteImagesUseCase()).thenAnswer(
        (_) => Future.value(
          [imageDtoDummy.copyWith(isFavorite: true)],
        ),
      );
    },
    seed: () => SearchState(
      searchStatus: SuccessSearchStatus(
        imagePagingVo: imagePagingVoDummy.copyWith(
          items: imagePagingVoDummy.items.map((imageVo) {
            if (imageVo == imageVoDummy) {
              return imageVoDummy.copyWith(isFavorite: true);
            }
            return imageVo;
          }).toList(),
        ),
      ),
      query: '',
      favoriteImages: List.empty(),
    ),
    act: (bloc) => bloc.add(GetFavoriteImagesEvent()),
    expect: () => [
      SearchState(
        searchStatus: SuccessSearchStatus(
          imagePagingVo: imagePagingVoDummy.copyWith(
            items: imagePagingVoDummy.items.map((imageVo) {
              if (imageVo == imageVoDummy) {
                return imageVoDummy.copyWith(isFavorite: true);
              }
              return imageVo;
            }).toList(),
          ),
        ),
        query: '',
        favoriteImages: [imageVoDummy.copyWith(isFavorite: true)],
      ),
    ],
  );
}
