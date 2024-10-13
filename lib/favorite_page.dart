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
    final imageListInfo = FavoriteImageListInfoImpl();
    imageListInfo.setImageItems(
      images: context.select((SearchBloc bloc) => bloc.state.favoriteImages),
    );

    return _ImageListView(imageListInfo: imageListInfo);
  }

  @override
  bool get wantKeepAlive => true;
}
