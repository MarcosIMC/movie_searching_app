import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_searching/services/movie_api.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

Future<List<dynamic>> fetchCarouselMovies() async {
  final data = await MovieApi().getListMovies('moviesToCarousel');
  return data;
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchCarouselMovies(),
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
            return CarouselSlider(
                items: snapshot.data?.map((item) => Container(
                  child: Center(
                    child: Image.network(item['Poster'], fit: BoxFit.cover, width: 1000),
                  ),
                )).toList(),
                options: CarouselOptions(
                    height: 180,
                    aspectRatio: 16/9,
                    viewportFraction: 0.2,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    reverse: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    scrollDirection: Axis.horizontal
                )
            );
          }
        }
    );
  }
}
