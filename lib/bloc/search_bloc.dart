import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/model/image_vo.dart';
import 'package:search/model/paging_vo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    on<SearchImagesEvent>(_searchImages);
    on<UpdateKeyword>(_updateKeyword);
  }

  _searchImages(
    SearchImagesEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(searchStatus: LoadingSearchStatus()));

    Future.delayed(const Duration(seconds: 2));
    try {
      final images = List.generate(10, (index) {
        return ImageVo(
          imageId: 'https://picsum.photos/id/$index/100/300',
          imageUrl:
              'https://img.freepik.com/free-photo/couple-making-heart-from-hands-sea-shore_23-2148019887.jpg',
          label: 'Image $index',
          isFavorite: false,
        );
      });
      final PagingVo<ImageVo> imagePagingVo = PagingVo(
        items: images,
        totalCount: images.length,
        hasNextPage: false,
        page: 1,
      );
      emit(
        state.copyWith(
          searchStatus: SuccessSearchStatus(imagePagingVo: imagePagingVo),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(searchStatus: FailureSearchStatus(error: e.toString())),
      );
    }
  }

  _updateKeyword(UpdateKeyword event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      searchStatus:
          event.keyword.isEmpty ? InitialSearchStatus() : state.searchStatus,
      keyword: event.keyword,
    ));
  }
}
