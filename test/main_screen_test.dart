import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_searching/providers/movie_provider.dart';
import 'package:movie_searching/providers/user_provider.dart';
import 'package:movie_searching/screens/main_screen.dart';
import 'package:movie_searching/screens/movie_details_screen.dart';
import 'package:movie_searching/widgets/card_movie.dart';
import 'package:movie_searching/widgets/carousel.dart';
import 'package:movie_searching/widgets/movie_item.dart';
import 'package:provider/provider.dart';

void main() {
  group('Main screen widget should', () {
    late UserProvider userProvider;
    late MovieProvider movieProvider;

    setUp(() {
      userProvider = UserProvider();
      movieProvider = MovieProvider();
    });

    Widget buildTestableWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: userProvider,),
          ChangeNotifierProvider<MovieProvider>.value(value: movieProvider,)
        ],
        child: const MaterialApp(
          home: MainScreen(),
        ),
      );
    }

    testWidgets('Renderiza todos los elementos iniciales', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      expect(find.text('Movie Searching'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(SegmentedButton<bool>), findsOneWidget);
      expect(find.byType(Carousel), findsOneWidget);
      expect(find.byType(MovieItem), findsOneWidget);
    });
    
    testWidgets('Change "all" to "fav" button filter', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      //check by default its setter to all
      /*final segmented = tester.widget<SegmentedButton<bool>>(find.byType(SegmentedButton));
      expect(segmented.selected, contains(true));*/
      
      //tap in "favoritos"
      await tester.tap(find.text('Favoritos'));
      await tester.pumpAndSettle();
      
      //Change text
      if (userProvider.user == null) {
        expect(find.text('Inicia sesión para ver tus favoritos'), findsOneWidget);
      } else {
        expect(find.text('Aún no tienes películas favoritas'), findsOneWidget);
      }
    });

    testWidgets('Search a movie', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Batman');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.byType(MovieItem), findsOneWidget);
    });
  });
}