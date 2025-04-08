import 'package:movie_searching/models/person.dart';

class User extends Person {
  final email;
  final password;

  User(super.name, super.surname, super.birthdate, this.email, this.password);

}