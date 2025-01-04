// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';TextField).evaluate().first.widget as TextField;

        // act & assert
        expect(
          textField.decoration?.hintText,
          equals('검색어를 입력하세요'),
        );
      },
    );

    testWidgets(
      '검색 창에 검색어를 [testing] 입력했을 때 [testing] 문자 노출 확인',
      (WidgetTester tester) async {
        // arrange
        await tester.pumpWidget(const MyApp());

        final textField =
            find.byType(TextField).evaluate().first.widget as TextField;

        // act
        textField.controller?.text = 'testing';

        // assert
        expect(
          find.text('testing'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      '즐겨찾기 탭을 선택했을 때 [즐겨찾기한 이미지가 없습니다] 메시지 노출 확인',
      (WidgetTester tester) async {
        // arrange
        await tester.pumpWidget(const MyApp());

        final tabBar = find.byType(TabBar).evaluate().first.widget as TabBar;

        // act
        tabBar.controller?.index = 1;

        await tester.pumpAndSettle();

        // assert
        expect(
          find.text('즐겨찾기한 이미지가 없습니다'),
          findsOneWidget,
        );
      },
    );
  });
}
