part of 'main.dart';

class _FavoritePage extends StatelessWidget {
  const _FavoritePage();

  @override
  Widget build(BuildContext context) {
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
}
