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
                decoration: InputDecoration(
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
                  print('text: $text');
                },
                onSubmitted: (text) {
                  print('submitted: $text');
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.clear),
              color: Colors.grey,
              onPressed: () {},
            ),
          ],
        ),
        _ImageListView(),
      ],
    );
  }
}
