import 'package:movie_searching/models/person.dart';

class Movie {
  final String title;
  final String plot;
  final String poster;
  final String year;
  final String runTime;
  final String released;
  final String awards;
  final List<Person> actors;

  Movie(this.title, this.plot, this.poster, this.actors, this.year, this.runTime, this.released, this.awards);
}