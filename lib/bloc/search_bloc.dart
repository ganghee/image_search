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
    if (_isQueryCleared(isRefresh: event.isRefresh, query: event.query)) {
      emit(state.copyWith(searchStatus: InitialSearchStatus()));
      return;
    }

    PagingVo imagePagingVo = PagingVo.init();
    if (state.searchStatus.isSuccess) {
      imagePagingVo = (state.searchStatus as SuccessSearchStatus).imagePagingVo;
    } else if (state.searchStatus.isInitial) {
      emit(state.copyWith(searchStatus: LoadingSearchStatus()));
    }

    // 페이지가 로딩 중이거나 마지막 페이지인 경우 추가 요청을 하지 않는다.
    if (state.searchStatus.isLoading && imagePagingVo.hasNextPage == false) {
      return;
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
          totalCount: newImagePagingDto.metaDto.totalCount,
          hasNextPage: newImagePagingDto.metaDto.isEnd,
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
