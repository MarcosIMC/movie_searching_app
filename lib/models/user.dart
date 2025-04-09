import 'package:movie_searching/models/movie.dart';
import 'package:movie_searching/models/person.dart';

class User extends Person {
  final String id;
  final email;
  final password;
  final List<Movie> favMovies;

  User(super.name, super.surname, this.email, this.password, this.id, this.favMovies);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'movies': favMovies
    };
  }

}