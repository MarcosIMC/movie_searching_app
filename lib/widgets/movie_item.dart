import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../screens/movie_details_screen.dart';
import '../services/movie_api.dart';
import 'card_movie.dart';

class MovieItem extends StatefulWidget {
  final String? title;
  
  const MovieItem({super.key, this.title});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

Future<List<dynamic>> fetchMovieList() async {
  final data = await MovieApi().getListMovies('moviesToList');
  return data;
}

Future<List<dynamic>> fetchMovie(String title) async {
  final data = await MovieApi().getMovie(title);
  return data;
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: widget.title == null ? fetchMovieList() : fetchMovie(widget.title!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No se encontraron películas'),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final movie = Movie(snapshot.data![index]['Title'], snapshot.data![index]['Plot'], snapshot.data![index]['Poster'], [], snapshot.data![index]['Year'], snapshot.data![index]['Runtime'], snapshot.data![index]['Released'], snapshot.data![index]['Awards']);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie)));
                    },
                    child: CardMovie(movie: movie)
                    ,
                  );
                },
              ),
            );
          }
        }
    );
  }
}