class PagingVo<T> {
  final int page;
  final int totalCount;
  final bool hasNextPage;
  final List<T> items;

  PagingVo({
    required this.page,
    required this.totalCount,
    required this.hasNextPage,
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
        items: items,
      );
}
