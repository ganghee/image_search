part of 'main.dart';

class _SearchPage extends StatefulWidget {
  final TabController tabController;

  const _SearchPage({required this.tabController});

  @override
  State<_SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage> {
  late final TextEditingController _textFieldController =
      TextEditingController();
  late final FocusNode _focusNode = FocusNode();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textFieldController,
                focusNode: _focusNode,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: '검색어를 입력하세요',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (text) {
                  context
                      .read<SearchBloc>()
                      .add(SearchImagesEvent(query: text, isRefresh: true));
                },
              ),
            ),
            _queryClearIconButton(),
          ],
        ),
        _searchStatusView(
          searchStatus: context.select(
            (SearchBloc bloc) => bloc.state.searchStatus,
          ),
        ),
      ],
    );
  }

  Widget _searchStatusView({required SearchStatus searchStatus}) {
    if (searchStatus.isInitial) {
      return _initialView();
    } else if (searchStatus.isLoading) {
      return _loadingView();
    } else if (searchStatus.isSuccess) {
      return _ImageListView(
        images: (searchStatus as SuccessSearchStatus).imagePagingVo.items,
        focusNode: _focusNode,
      );
    } else if (searchStatus.isFailure) {
      return _errorView();
    } else {
      return const SizedBox();
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
      topMargin: 80,
    );
  }

  Widget _initialView() {
    return iconMessageView(
      icon: Icons.image_search,
      message: '검색어를 입력하세요',
      topMargin: 80,
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
}
