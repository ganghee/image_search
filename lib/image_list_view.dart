part of 'main.dart';

class _ImageListView extends StatefulWidget {
  final List<ImageVo> images;
  final FocusNode? focusNode;

  const _ImageListView({
    required this.images,
    this.focusNode,
  });

  @override
  State<_ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<_ImageListView> {
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      _unFocusTextField();
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 300) {
        context.read<SearchBloc>().add(
              SearchImagesEvent(isRefresh: false),
            );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.images.isEmpty
        ? iconMessageView(
            icon: Icons.search_off,
            message: '검색 결과가 없습니다',
            topMargin: 80,
          )
        : Expanded(
            child: GridView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: widget.images.length,
              itemBuilder: (BuildContext context, int index) {
                return _imageItemView(imageVo: widget.images[index]);
              },
            ),
          );
  }

  Widget _imageItemView({required ImageVo imageVo}) {
    return GestureDetector(
      onTap: () {
        _unFocusTextField();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ImageDetailScreen(imageUrl: imageVo.imageUrl),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.05),
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 이미지
            Image.network(
              imageVo.imageUrl,
              fit: BoxFit.cover,
              cacheHeight: imageVo.height,
              cacheWidth: imageVo.width,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error));
              },
            ),
            // 이미지 라벨
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                imageVo.label,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // 좋아요 아이콘
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: _FavoriteIconView(
                  isFavorite: imageVo.isFavorite,
                  onTap: () {
                    context.read<SearchBloc>().add(
                          UpdateFavoriteEvent(imageVo: imageVo),
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _unFocusTextField() {
    if (widget.focusNode?.hasFocus == true) {
      widget.focusNode?.unfocus();
    }
  }
}
