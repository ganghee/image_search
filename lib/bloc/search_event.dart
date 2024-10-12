part of 'search_bloc.dart';

sealed class SearchEvent {}

final class SearchImagesEvent extends SearchEvent {
  final String? keyword;

  SearchImagesEvent({this.keyword});
}

final class UpdateLikeEvent extends SearchEvent {
  final int imageId;
  final bool isFavorite;

  UpdateLikeEvent(this.imageId, this.isFavorite);
}

final class UpdateKeyword extends SearchEvent {
  final String keyword;

  UpdateKeyword(this.keyword);
}
