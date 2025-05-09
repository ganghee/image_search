part of 'main.dart';

class _SearchPage extends StatefulWidget {
  final TabController tabController;

  const _SearchPage({required this.tabController});

  @override
  State<_SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController _textFieldController =
      TextEditingController();
  late final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  late final Duration _debounceDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    widget.tabController.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        _searchStatusView(
          searchStatus: context.select(
            (SearchBloc bloc) => bloc.state.searchStatus,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8, left: 4, right: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextField(
            controller: _textFieldController,
            focusNode: _focusNode,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '검색어를 입력하세요',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _queryClearIconButton(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            onChanged: (text) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(
                _debounceDuration,
                () {
                  context.read<SearchBloc>().add(
                        SearchImagesEvent(
                          query: text.trim(),
                          isRefresh: true,
                        ),
                      );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _searchStatusView({required SearchStatus searchStatus}) {
    switch (searchStatus) {
      case InitialSearchStatus():
        return _initialView();
      case LoadingSearchStatus():
        return _loadingView();
      case SuccessSearchStatus():
        final imageListInfo =
            ImageListFactory.createImageList(type: ImageListType.search)
              ..setImageItems(images: (searchStatus).imagePagingVo.items)
              ..setFocusNode(focusNode: _focusNode);
        return _ImageListView(imageListInfo: imageListInfo);
      case FailureSearchStatus():
        return _errorView();
    }
  }

  Widget _loadingView() {
    return const Padding(
      padding: EdgeInsets.only(top: 120),
      child: Center(
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );
  }

  Widget _errorView() {
    return iconMessageView(
      icon: Icons.error,
      message: '검색에 실패했습니다',
      topMargin: 120,
    );
  }

  Widget _initialView() {
    return iconMessageView(
      icon: Icons.image_search,
      message: '검색어를 입력하세요',
      topMargin: 120,
    );
  }

  Widget _queryClearIconButton() {
    return Visibility(
      visible: _textFieldController.text.isNotEmpty,
      child: IconButton(
        icon: const Icon(Icons.clear),
        color: Colors.grey,
        onPressed: () {
          _textFieldController.clear();
          context
              .read<SearchBloc>()
              .add(SearchImagesEvent(query: '', isRefresh: true));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
