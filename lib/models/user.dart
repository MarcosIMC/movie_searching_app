import 'package:movie_searching/models/movie.dart';
import 'package:movie_searching/models/person.dart';

class User extends Person {
  final String id;
  final email;
  final password;
  List<Movie>? favMovies;

  User(super.name, super.surname, {
    required this.id,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'password': password
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(map['name'], map['surname'], id: map['id'], email: map['email'], password: map['password']);
  }
}