part of 'main.dart';

class _FavoritePage extends StatefulWidget {
  const _FavoritePage();

  @override
  State<_FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<_FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return _ImageListView();
  }
}
