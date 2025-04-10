import 'package:flutter/material.dart';
import 'package:movie_searching/models/movie.dart';
import 'package:movie_searching/providers/movie_provider.dart';
import 'package:movie_searching/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.movie.poster),
            userProvider.user != null ?
            IconButton(onPressed: () {
              setState(() {
                _isFav = !_isFav;
                movieProvider.addMovieToFav(widget.movie.title);
              });
            }, icon: Icon(_isFav ? Icons.favorite : Icons.favorite_border))
            : Text(''),
            Divider(height: 10,),
            Text(widget.movie.plot,
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
