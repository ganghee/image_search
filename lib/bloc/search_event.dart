part of 'search_bloc.dart';

sealed class SearchEvent {}

final class SearchImagesEvent extends SearchEvent {
  final String? query;
  final bool isRefresh;

  SearchImagesEvent({required this.isRefresh, this.query});
}

final class UpdateFavoriteEvent extends SearchEvent {
  final ImageVo imageVo;

  UpdateFavoriteEvent({required this.imageVo});
}

final class GetFavoriteImagesEvent extends SearchEvent {}
