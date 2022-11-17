import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiperScreen extends StatelessWidget {
  const CardSwiperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: _size.height * 0.55,
      child: Swiper(
        autoplay: true,
        autoplayDelay: kDefaultAutoplayDelayMs + 5000,
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: _size.width * 0.6,
        itemHeight: _size.height * 0.9,
        itemBuilder: (context, _) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage('https://picsum.photos/300/400'),
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
