import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class CardSwiperScreen extends StatelessWidget {
  const CardSwiperScreen({
    Key? key,
    required this.movies,
  }) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: _size.height * 0.55,
      child: Swiper(
        autoplay: true,
        autoplayDelay: kDefaultAutoplayDelayMs + 5000,
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: _size.width * 0.6,
        itemHeight: _size.height * 0.9,
        itemBuilder: (_, index) {
          final movie = movies[index];

          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: 'movie-instance'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
