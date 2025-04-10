import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_searching/models/movie.dart';
import 'package:movie_searching/providers/movie_provider.dart';
import 'package:movie_searching/providers/user_provider.dart';
import 'package:movie_searching/screens/login_screen.dart';
import 'package:movie_searching/screens/movie_details_screen.dart';
import 'package:movie_searching/screens/profile_secreen.dart';
import 'package:movie_searching/services/sql_helper.dart';
import 'package:movie_searching/widgets/card_movie.dart';
import 'package:movie_searching/widgets/carousel.dart';
import 'package:movie_searching/widgets/movie_item.dart';
import 'package:provider/provider.dart';

import '../services/movie_api.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

Future<List<dynamic>> fetchMovies() async {
  final data = await MovieApi().getListMovies('moviesToList');
  return data;
}

class _MainScreenState extends State<MainScreen> {
  bool _allMovies = true;
  String? title;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Searching'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => userProvider.user == null ? LoginScreen() : ProfileSecreen(user: userProvider.user!)));
          }, icon: Icon(Icons.account_circle_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: 'Buscar películas...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder()
              ),
              onSubmitted: (query) {
                setState(() {
                  if (query.isNotEmpty) {
                    title = query;
                  } else {
                    title = null;
                  }
                });
              },
            ),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: true, label: Text('Todos')),
                ButtonSegment(value: false, label: Text('Favoritos'))
              ],
              selected: {_allMovies},
              onSelectionChanged: (Set<bool> selected) {
                setState(() {
                  _allMovies = selected.isNotEmpty ? selected.first : false;
                });
              },
            ),
            SizedBox(height: 5,),
            Divider(height: 20,),
            Carousel(),
            SizedBox(height: 20,),
            _allMovies ?
            MovieItem(title: title,)
                : movieProvider.favMoviesTitle.isNotEmpty && userProvider.user != null ?
            MovieItem(title: title,)
                : Text(userProvider.user != null ? 'Aún no tienes películas favoritas' : 'Inicia sesión para ver tus favoritos')
          ],
        ),
      )
    );
  }
}
