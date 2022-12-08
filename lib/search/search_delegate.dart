import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => {
          query = '',
        },
        icon: const Icon(Icons.clear_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesProviders = Provider.of<MoviesProvider>(context);

    if (query.isEmpty) {
      return const _EmptyContainer();
    }

    // return FutureBuilder(
    // future: moviesProviders.searchMovie(query),
    return StreamBuilder(
      stream: moviesProviders.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        final movie = snapshot.data;

        if (!snapshot.hasData) return const _EmptyContainer();

        return _ResultMovieSearch(movies: movie!);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProviders = Provider.of<MoviesProvider>(context);
    moviesProviders.getSuggestionsByQuery(query);

    if (query.isEmpty) {
      return const _EmptyContainer();
    }

    return StreamBuilder(
      stream: moviesProviders.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        final movie = snapshot.data;

        if (!snapshot.hasData) return const _EmptyContainer();

        return _ResultMovieSearch(movies: movie!);
      },
    );
  }
}

class _EmptyContainer extends StatelessWidget {
  const _EmptyContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.movie_creation_outlined, size: 200),
    );
  }
}

class _ResultMovieSearch extends StatelessWidget {
  const _ResultMovieSearch({
    Key? key,
    required this.movies,
  }) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      // shrinkWrap: true,
      itemBuilder: (_, int index) {
        final Movie movie = movies[index];
        movie.heroId = 'search-${movie.id}';
        return ListTile(
          leading: Hero(
            tag: movie.heroId!,
            child: FadeInImage(
              width: 80,
              fit: BoxFit.contain,
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullBackdropPath),
            ),
          ),
          title: Text(movie.title),
          subtitle: Text(movie.originalTitle),
          onTap: () {
            Navigator.pushNamed(context, 'details', arguments: movie);
          },
        );

        // return Row(
        //   children: [
        //     Container(
        //       margin: const EdgeInsets.all(8),
        //       height: size.height / 8,
        //       width: size.width / 6,
        //       // color: Colors.red,
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(20),
        //         child: FadeInImage(
        //           fit: BoxFit.cover,
        //           placeholder: const AssetImage('assets/no-image.jpg'),
        //           image: NetworkImage(movies[index].fullPosterImg),
        //         ),
        //       ),
        //     ),
        //     // Spacer()
        //   ],
        // );
      },
    );
  }
}
