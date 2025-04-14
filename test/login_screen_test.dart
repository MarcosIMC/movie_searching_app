import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_searching/providers/user_provider.dart';
import 'package:movie_searching/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Login screen should', () {
    late UserProvider userProvider;

    setUpAll(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() {
      userProvider = UserProvider();
    });

    Widget buildTestableWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: userProvider,),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      );
    }

    testWidgets('Render all view elements', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      expect(find.byType(TextFormField).first, findsOneWidget);
      expect(find.byType(TextFormField).last, findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('Press "Login" button without any text in the form', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Insert a valid email'), findsOneWidget);
      expect(find.text('Insert a valid password'), findsOneWidget);
    });

    testWidgets('Press "Login" button with text in the form', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      
      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'ab@ab.es');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), '12345');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Insert a valid email'), findsNothing);
      expect(find.text('Insert a valid password'), findsNothing);
    });
  });
}