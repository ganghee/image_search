part of 'search_bloc.dart';

sealed class SearchEvent {}

final class SearchImagesEvent extends SearchEvent {
  final String? query;
  final bool isRefresh;

  SearchImagesEvent({required this.isRefresh, this.query});
}

final class UpdateLikeEvent extends SearchEvent {
  final int imageId;
  final bool isFavorite;

  UpdateLikeEvent(this.imageId, this.isFavorite);
}
