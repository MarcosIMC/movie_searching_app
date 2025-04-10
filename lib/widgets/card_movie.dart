import 'package:flutter/material.dart';
import 'package:movie_searching/models/movie.dart';

class CardMovie extends StatefulWidget {
  final Movie movie;

  const CardMovie({super.key, required this.movie});

  @override
  State<CardMovie> createState() => _CardMovieState();
}

class _CardMovieState extends State<CardMovie> {


  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    return Card(
      child: Column(
        children: [
          Image.network(movie.poster),
          Text(movie.title),
          Text('${movie.plot.substring(0, 50)}...')
        ],
      ),
    );
  }
}
