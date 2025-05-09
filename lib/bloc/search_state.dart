part of 'search_bloc.dart';

final class SearchState extends Equatable {
  final SearchStatus searchStatus;
  final String? query;
  final List<ImageVo> favoriteImages;

  const SearchState({
    required this.searchStatus,
    required this.query,
    required this.favoriteImages,
  });

  factory SearchState.initial() {
    return SearchState(
      searchStatus: InitialSearchStatus(),
      query: '',
      favoriteImages: List.empty(),
    );
  }

  SearchState copyWith({
    SearchStatus? searchStatus,
    String? query,
    List<ImageVo>? favoriteImages,
  }) =>
      SearchState(
        searchStatus: searchStatus ?? this.searchStatus,
        query: query ?? this.query,
        favoriteImages: favoriteImages ?? this.favoriteImages,
      );

  @override
  List<Object?> get props => [searchStatus, query, favoriteImages];
}

sealed class SearchStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialSearchStatus extends SearchStatus {}

final class LoadingSearchStatus extends SearchStatus {}

final class SuccessSearchStatus extends SearchStatus {
  final PagingVo<ImageVo> imagePagingVo;

  SuccessSearchStatus({required this.imagePagingVo});

  @override
  List<Object?> get props => [imagePagingVo];
}

final class FailureSearchStatus extends SearchStatus {
  final String error;
  final String inner = 'inner';

  FailureSearchStatus({required this.error});

  @override
  List<Object?> get props => [error];
}

extension SearchStatusExtension on SearchStatus {
  bool get isInitial => this is InitialSearchStatus;

  bool get isLoading => this is LoadingSearchStatus;

  bool get isSuccess => this is SuccessSearchStatus;

  bool get isFailure => this is FailureSearchStatus;
}
