part of 'main.dart';

class _SearchPage extends StatefulWidget {
  const _SearchPage();

  @override
  State<_SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: '검색어를 입력하세요',
                  prefixIcon: Icon(Icons.search),
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
                      .add(SearchImagesEvent(keyword: text));
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              color: Colors.grey,
              onPressed: () {},
            ),
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
    print('searchStatus: $searchStatus');
    if (searchStatus.isInitial) {
      return _initialView();
    } else if (searchStatus.isLoading) {
      return _loadingView();
    } else if (searchStatus.isSuccess) {
      return _imageListView();
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
    return const Center(
      child: Text('에러입니다.'),
    );
  }

  Widget _imageListView() {
    return _ImageListView(
      images: context.select(
        (SearchBloc bloc) => (bloc.state.searchStatus as SuccessSearchStatus)
            .imagePagingVo
            .items,
      ),
    );
  }

  Widget _initialView() {
    return const Expanded(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Icon(Icons.image_search, size: 80),
            SizedBox(height: 10),
            Text('검색어를 입력하세요'),
          ],
        ),
      ),
    );
  }
}
