part of 'main.dart';

class _FavoritePage extends StatefulWidget {
  const _FavoritePage();

  @override
  State<_FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<_FavoritePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Flex(
      direction: Axis.vertical,
      children: [
        _ImageListView(
          images:
              context.select((SearchBloc bloc) => bloc.state.favoriteImages),
          emptyMessage: '즐겨찾기한 이미지가 없습니다',
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
