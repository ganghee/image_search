import 'package:flutter/material.dart';

part 'favorite_page.dart';
part 'image_list_view.dart';
part 'search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
  );
  late final PageController _pageController = PageController();

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _tabMenu(
              tabController: _tabController,
              tabs: const [
                Tab(text: '검색'),
                Tab(text: '즐겨찾기'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _SearchPage(),
                  _FavoritePage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabMenu({
    required TabController tabController,
    required List<Tab> tabs,
  }) {
    return TabBar.secondary(
      controller: tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0),
        insets: EdgeInsets.symmetric(horizontal: 24),
      ),
      dividerColor: Colors.grey,
      labelColor: Colors.black,
      labelStyle: Typography.material2021().black.headlineLarge,
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: Typography.material2021().black.bodyMedium,
      tabs: tabs,
      onTap: (index) {
        tabController.animateTo(index);
      },
    );
  }
}
