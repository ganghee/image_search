part of 'search_bloc.dart';

final class SearchState {
  final SearchStatus searchStatus;
  final String? query;

  SearchState({
    required this.searchStatus,
    required this.query,
  });

  factory SearchState.initial() {
    return SearchState(
      searchStatus: InitialSearchStatus(),
      query: '',
    );
  }

  SearchState copyWith({
    SearchStatus? searchStatus,
    String? query,
  }) {
    return SearchState(
      searchStatus: searchStatus ?? this.searchStatus,
      query: query ?? this.query,
    );
  }
}

sealed class SearchStatus {}

final class InitialSearchStatus extends SearchStatus {}

final class LoadingSearchStatus extends SearchStatus {}

final class SuccessSearchStatus extends SearchStatus {
  final PagingVo<ImageVo> imagePagingVo;

  SuccessSearchStatus({required this.imagePagingVo});
}

final class FailureSearchStatus extends SearchStatus {
  final String error;

  FailureSearchStatus({required this.error});
}

extension SearchStatusExtension on SearchStatus {
  bool get isInitial => this is InitialSearchStatus;

  bool get isLoading => this is LoadingSearchStatus;

  bool get isSuccess => this is SuccessSearchStatus;

  bool get isFailure => this is FailureSearchStatus;
}
