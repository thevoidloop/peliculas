import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'e56911795ed3760fa85d98f91bceae8a';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-Es';
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovie();
  }

  Future<String> _getJsonData(String endPoint,
      {int page = 1, String query = ''}) async {
    var url = Uri.https(_baseUrl, endPoint, {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
      'page': '$page',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    final NowPlayingResponse nowPlayingResponse =
        NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovie() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', page: _popularPage);

    final PopularResponse popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Movie>> searchMovie(String query) async {
    final jsonData = await _getJsonData('3/search/movie', query: query);

    final SearchResponse searchResponse = SearchResponse.fromJson(jsonData);

    return searchResponse.results;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  void getSuggestionsByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Tenemos valor a buscar: $value');
      final result = await searchMovie(value);
      _suggestionStreamController.add(result);
    };

    final timer = Timer(
      const Duration(milliseconds: 300),
      () {
        debouncer.value = query;
      },
    );

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
