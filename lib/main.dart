import 'package:domain/use_case/search_images_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator/get_it.dart';
import 'package:search/bloc/search_bloc.dart';
import 'package:search/model/image_vo.dart';

part 'favorite_page.dart';
part 'icon_message_view.dart';
part 'image_list_view.dart';
part 'search_page.dart';

void main() {
  initLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          surface: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => SearchBloc(locator<SearchImagesUseCase>()),
        child: const _HomeView(),
      ),
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

  @override
  void dispose() {
    _tabController.dispose();
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
