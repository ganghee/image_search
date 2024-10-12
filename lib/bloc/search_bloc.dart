import 'package:domain/use_case/search_images_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/model/image_vo.dart';
import 'package:search/model/paging_vo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchImagesUseCase _searchImagesUseCase;

  SearchBloc(this._searchImagesUseCase) : super(SearchState.initial()) {
    on<SearchImagesEvent>(_searchImages);
  }

  _searchImages(
    SearchImagesEvent event,
    Emitter<SearchState> emit,
  ) async {
    // 검색창 초기화 경우
    if (_isQueryCleared(isRefresh: event.isRefresh, query: event.query)) {
      emit(state.copyWith(searchStatus: InitialSearchStatus()));
      return;
    }

    PagingVo imagePagingVo = PagingVo.init();

    // 이미지 검색 성공 상태인 경우 페이징 정보를 유지
    if (state.searchStatus.isSuccess && !event.isRefresh) {
      final existingImagePagingVo =
          (state.searchStatus as SuccessSearchStatus).imagePagingVo;

      // 이미지 검색 중인 경우 또는 다음 페이지가 없는 경우 무시
      if (existingImagePagingVo.isPageLoading ||
          !existingImagePagingVo.hasNextPage) {
        return;
      }

      imagePagingVo = existingImagePagingVo.copyWith(isPageLoading: true);
      emit(
        state.copyWith(
          searchStatus: SuccessSearchStatus(
            imagePagingVo: imagePagingVo as PagingVo<ImageVo>,
          ),
        ),
      );
    }

    // 초기 상태인 경우 검색 시 또는 검색어 변경 시 로딩 상태로 변경
    if (state.searchStatus.isInitial || event.isRefresh) {
      emit(state.copyWith(searchStatus: LoadingSearchStatus()));
    }

    final List<ImageVo> images = [];
    if (!event.isRefresh) {
      images.addAll(imagePagingVo.items as List<ImageVo>);
    }

    try {
      final newImagePagingVo = await _searchImagesUseCase(
        query: event.isRefresh ? (event.query ?? '') : (state.query ?? ''),
        page: event.isRefresh ? 1 : imagePagingVo.page + 1,
      ).then((newImagePagingDto) {
        images.addAll(
          newImagePagingDto.documents
              .map((imageDto) => imageDto.mapper())
              .toList(),
        );

        return PagingVo(
          items: images,
          page: event.isRefresh ? 1 : imagePagingVo.page + 1,
          totalCount: newImagePagingDto.metaDto.pageableCount,
          hasNextPage: !newImagePagingDto.metaDto.isEnd,
          isPageLoading: false,
        );
      });
      emit(
        state.copyWith(
          query: event.query ?? state.query,
          searchStatus: SuccessSearchStatus(imagePagingVo: newImagePagingVo),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(searchStatus: FailureSearchStatus(error: e.toString())),
      );
    }
  }

  bool _isQueryCleared({
    required bool isRefresh,
    required String? query,
  }) =>
      isRefresh && query?.isEmpty == true;
}
