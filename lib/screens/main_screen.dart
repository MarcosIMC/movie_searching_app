import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_searching/models/movie.dart';
import 'package:movie_searching/screens/login_screen.dart';
import 'package:movie_searching/screens/movie_details_screen.dart';
import 'package:movie_searching/widgets/card_movie.dart';
import 'package:movie_searching/widgets/carousel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _allMovies = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Searching'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  final movie = Movie('Titanic', 'Gran película de un buque enorme que quiere ir a USA pero se le complica...', 'https://i.ytimg.com/vi/A1FtRovJMxk/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDSDRGU7c9EGMuHNqhR9nbWEfFrrg', []);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie)));
                    },
                    child: CardMovie(movie: movie)
                    ,
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
