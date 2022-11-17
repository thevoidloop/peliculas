import 'package:flutter/material.dart';
import 'package:peliculas/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        actions: [
          IconButton(
            onPressed: () {},
            padding: const EdgeInsets.symmetric(horizontal: 15),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiperScreen(),
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}
