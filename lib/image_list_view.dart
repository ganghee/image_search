part of 'main.dart';

class _ImageListView extends StatefulWidget {
  final List<ImageVo> images;

  const _ImageListView({required this.images});

  @override
  State<_ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<_ImageListView> {
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
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
        ? Padding(
            padding: const EdgeInsets.only(top: 80),
            child: _iconMessageView(
              icon: Icons.search_off,
              message: '검색 결과가 없습니다',
            ),
          )
        : Expanded(
            child: GridView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 1,
              ),
              itemCount: widget.images.length,
              itemBuilder: (BuildContext context, int index) {
                return _imageItemView(image: widget.images[index]);
              },
            ),
          );
  }

  Widget _imageItemView({required ImageVo image}) {
    return Container(
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
          Image.network(
            image.imageUrl,
            fit: BoxFit.cover,
            cacheHeight: image.height,
            cacheWidth: image.width,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.error));
            },
          ),
          Text(image.label),
        ],
      ),
    );
  }
}
