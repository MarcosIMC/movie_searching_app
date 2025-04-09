import 'package:flutter/material.dart';
import 'package:movie_searching/models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(movie.urlImage),
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
            Divider(height: 10,),
            Text(movie.description,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20
              ),
            )
          ],
        ),
      )
    );
  }
}
