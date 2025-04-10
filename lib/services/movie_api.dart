import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  final String baseURL = dotenv.env['BASE_URL']!;
  final String apiKey = dotenv.env['API_MOVIE_KEY']!;
  final moviesToCarousel = ['titanic', 'the batman', 'thor', 'joker', 'gladiator', 'transformer'];
  final moviesToList = ['godzilla', 'Interstellar', 'Django Unchained', 'Drive', 'The Revenant', 'Alien'];

  //GetAllMovies
  //Ya que la API no tiene opción a traer las X últimas, las simulamos con la lista.
  Future<List<dynamic>> getListMovies(String list) async {
    var uri;
    var jsonResult = [];
    var response;

    for(var movie in list == 'moviesToList' ? moviesToList : moviesToCarousel) {
      uri = Uri.parse('$baseURL$movie&apikey=$apiKey');
      response = await http.get(
        uri,
      );

      if (response.statusCode == 200) {
        jsonResult.add(json.decode(response.body));
      } else {
        throw Exception('Error al obtener las películas del carousel. ${response.statusCode}');
      }
    }
    return jsonResult;
  }

  Future<List<dynamic>> getMovie(String title) async {
    var uri = Uri.parse('$baseURL$title&apikey=$apiKey');
    var response = await http.get(uri);
    var jsonResult = [];

    if (response.statusCode == 200) {
      jsonResult.add(json.decode(response.body));
    } else {
      throw Exception('Error al obtener las películas del carousel. ${response.statusCode}');
    }

    return jsonResult;
  }

  Future<List<dynamic>> getFavMovies(List<String> favMovies) async {
    var uri;
    var response;
    var jsonResult = [];

    for (var title in favMovies) {
      uri = Uri.parse('$baseURL$title&apikey=$apiKey');
      response = await http.get(uri);

      if (response.statusCode == 200) {
        jsonResult.add(json.decode(response.body));
      } else {
        throw Exception('Error al obtener las películas del carousel. ${response.statusCode}');
      }
    }

    return jsonResult;
  }
}