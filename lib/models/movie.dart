import 'package:movie_searching/models/person.dart';

class Movie {
  final String title;
  final String description;
  final String urlImage;
  final List<Person> actors;

  Movie(this.title, this.description, this.urlImage, this.actors);
}