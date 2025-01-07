import 'package:equatable/equatable.dart';

class PagingVo<T> extends Equatable {
  final int page;
  final int totalCount;
  final bool hasNextPage;
  final bool isPageLoading;
  final List<T> items;

  const PagingVo({
    required this.page,
    required this.totalCount,
    required this.hasNextPage,
    required this.isPageLoading,
    required this.items,
  });

  factory PagingVo.init({
    int page = 0,
    int totalCount = 0,
    bool hasNextPage = true,
    List<T> items = const [],
  }) =>
      PagingVo(
        page: page,
        totalCount: totalCount,
        hasNextPage: hasNextPage,
        isPageLoading: false,
        items: items,
      );

  PagingVo<T> copyWith({
    int? page,
    int? totalCount,
    bool? hasNextPage,
    bool? isPageLoading,
    List<T>? items,
  }) {
    return PagingVo(
      page: page ?? this.page,
      totalCount: totalCount ?? this.totalCount,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props =>
      [page, totalCount, hasNextPage, isPageLoading, items];
}
