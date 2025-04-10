import 'package:flutter/widgets.dart';
import 'package:movie_searching/providers/user_provider.dart';
import 'package:movie_searching/services/sql_helper.dart';

class MovieProvider with ChangeNotifier {
  final SqlHelper _sqlHelper = SqlHelper.instance;
  final UserProvider provider = UserProvider();

  final List<String> _favMoviesTitle = [];

  List<String> get favMoviesTitle => _favMoviesTitle;

  void addMovieToFav(String title) async {
    _favMoviesTitle.add(title);
    notifyListeners();
  }

  void deleteMovieFromFav(String title) {
    _favMoviesTitle.removeWhere((movie) => movie == title);
    notifyListeners();
  }
}