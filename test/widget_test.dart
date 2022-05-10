// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_challenge/bloc/events/search_events.dart';
import 'package:weather_challenge/bloc/search_bloc.dart';
import 'package:weather_challenge/bloc/states/search_states.dart';
import 'package:weather_challenge/domain/domain.dart';

import 'package:weather_challenge/main.dart';
import 'package:weather_challenge/ui/pages/active_search_page.dart';
import 'package:weather_challenge/ui/widgets/search_bar.dart';
import 'package:weather_challenge/util/keys.dart';

class LocalMockDomain extends Mock implements BaseDomain {}

class MockSearchBloc extends MockBloc<SearchEvent, SearchStates>
    implements SearchBloc {}

void main() {
  Widget makeSearchPageTestable({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('SearchPage test', (WidgetTester tester) async {
    await tester.pumpWidget(
      makeSearchPageTestable(child: const MyApp()),
    );

    // Test first page
    final logoTextFinder = find.byKey(const Key(TestingKeys.logoImage));
    final searchBarFinder = find.byKey(const Key(TestingKeys.searchButton));

    expect(logoTextFinder, findsOneWidget);
    expect(searchBarFinder, findsOneWidget);

    await tester.tap(searchBarFinder);
    await tester.pumpAndSettle();

    // Test transition form page1 to page2
    final customSearchBarFinder = find.byType(CustomSearchBar);

    expect(customSearchBarFinder, findsOneWidget);
  });

  testWidgets('ActiveSearchPage test', (WidgetTester tester) async {
    final searchBloc = SearchBloc(baseDomain: LocalMockDomain());

    await tester.pumpWidget(
      makeSearchPageTestable(
        child: BlocProvider(
          create: (context) => searchBloc,
          child: const ActiveSearchPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Find search bar
    final customSearchBarFinder = find.byType(CustomSearchBar);

    expect(customSearchBarFinder, findsOneWidget);
    expect(find.byType(Spacer), findsOneWidget);
    //Enter text into textField
    final textFieldFinder = find.byKey(
      const Key(TestingKeys.searchBarTextField),
    );

    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, "Napoli");
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle(const Duration(seconds: 2));

    // I would like to check whether listview is rendered, but can't seem to figure it out :c
    //expect(find.text("No location found. Try again please..."), findsOneWidget);
  });
}
