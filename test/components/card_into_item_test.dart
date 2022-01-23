import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/components/card/card_info_item.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/service_locator.dart';

import '../mocks/cubits/commons/mock_commons.dart';

void main() {
  group('info rendering', () {
    testWidgets('Card info item is render without info if it is null', (WidgetTester tester) async {
      await _pumpPage(
        tester,
        info: null,
      );

      expect(find.byType(CardInfoItem), findsOneWidget);

      expect(find.text('test label'), findsOneWidget);
      expect(find.text('test info'), findsNothing);
    });

    testWidgets('Card info item is render with info if it is not null', (WidgetTester tester) async {
      await _pumpPage(
        tester,
        info: 'haha info',
      );

      expect(find.byType(CardInfoItem), findsOneWidget);

      expect(find.text('test label'), findsOneWidget);
      expect(find.text('haha info'), findsOneWidget);
    });
  });

  group('icon navigate_next rendering', () {
    testWidgets('Card info item is render without icon navigate_next if showArrow is false',
        (WidgetTester tester) async {
      await _pumpPage(
        tester,
        showArrow: false,
      );

      expect(find.byType(CardInfoItem), findsOneWidget);
      expect(find.byIcon(Icons.navigate_next), findsNothing);
    });

    testWidgets('Card info item is render without icon navigate_next if showArrow is true',
        (WidgetTester tester) async {
      await _pumpPage(
        tester,
        showArrow: true,
      );

      expect(find.byType(CardInfoItem), findsOneWidget);
      expect(find.byIcon(Icons.navigate_next), findsOneWidget);
    });
  });

  testWidgets('Card info item onTap trigger correctly', (WidgetTester tester) async {
    var _isTouch = false;

    await _pumpPage(tester, onTap: () {
      _isTouch = !_isTouch;
    });

    expect(_isTouch, isFalse);

    await tester.tap(find.byType(CardInfoItem));
    await tester.pumpAndSettle();

    expect(_isTouch, isTrue);

    await tester.tap(find.byType(CardInfoItem));
    await tester.pumpAndSettle();

    expect(_isTouch, isFalse);
  });
}

Future<void> _pumpPage(
  WidgetTester tester, {
  GestureTapCallback? onTap,
  String label = 'test label',
  String? info,
  bool showArrow = false,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => mockThemeCubit(),
          ),
        ],
        child: Scaffold(
          body: CardInfoItem(
            label: label,
            info: info,
            onTap: onTap,
            showArrow: showArrow,
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
