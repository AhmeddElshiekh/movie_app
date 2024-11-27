import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/movie_model.dart';

class MovieProvider with ChangeNotifier {
  bool _isLoadingRecommended = false;
  String? _errorMessageRecommended;
  IconData? _errorIconRecommended;
  MovieResponse? _recommendedMovies;

  bool _isLoadingTopMovies = false;
  String? _errorMessageTopMovies;
  IconData? _errorIconTopMovies;
  MovieResponse? _topMovies;



  bool _isLoadingNowPlayingMovies = false;
  String? _errorMessageNowPlayingMovies;
  IconData? _errorIconNowPlayingMovies;
  MovieResponse? _nowPlayingMovies;

  bool get isLoadingRecommended => _isLoadingRecommended;
  String? get errorMessageRecommended => _errorMessageRecommended;
  IconData? get errorIconRecommended => _errorIconRecommended;
  MovieResponse? get recommendedMovies => _recommendedMovies;

  bool get isLoadingTopMovies => _isLoadingTopMovies;
  String? get errorMessageTopMovies => _errorMessageTopMovies;
  IconData? get errorIconTopMovies => _errorIconTopMovies;
  MovieResponse? get topMovies => _topMovies;


  bool get isLoadingNowPlayingMovies => _isLoadingNowPlayingMovies;
  String? get errorMessageNowPlayingMovies => _errorMessageNowPlayingMovies;
  IconData? get errorIconNowPlayingMovies => _errorIconNowPlayingMovies;
  MovieResponse? get nowPlayingMovies => _nowPlayingMovies;


  final Dio _dio = Dio();


  Future<void> _fetchMovies(
      String endpoint, {
        required void Function(MovieResponse?) setMovies,
        required void Function(bool) setLoading,
        required void Function(String?) setErrorMessage,
        required void Function(IconData?) setErrorIcon,
      }) async {
    setLoading(true);
    setErrorMessage(null);
    setErrorIcon(null);
    notifyListeners();

    try {
      Response result = await _dio.get(endpoint);
      debugPrint('API Response: ${result.data}');
      setMovies(MovieResponse.fromJson(result.data));
    } on DioException catch (dioExp) {
      debugPrint('Dio Exception: ${dioExp.message}');
      final failure = ServerFailure.fromDioError(dioExp);
      setErrorMessage(failure.errMessage);
      setErrorIcon(failure.errIcon);
    } catch (e, stackTrace) {
      debugPrint('Unexpected Error: $e\n$stackTrace');
      setErrorMessage('Unexpected error occurred, please try again later.');
      setErrorIcon(Icons.error_outline);
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> fetchRecommendedMovies() async {
    const String endpoint =
        'https://api.themoviedb.org/3/movie/912649/recommendations?api_key=b9d0ed699ad4607d82e0ce0ebe600ce7';

    await _fetchMovies(
      endpoint,
      setMovies: (movies) => _recommendedMovies = movies,
      setLoading: (loading) => _isLoadingRecommended = loading,
      setErrorMessage: (message) => _errorMessageRecommended = message,
      setErrorIcon: (icon) => _errorIconRecommended = icon,
    );
  }

  Future<void> fetchTopMovies() async {
    const String endpoint =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=b9d0ed699ad4607d82e0ce0ebe600ce7';

    await _fetchMovies(
      endpoint,
      setMovies: (movies) => _topMovies = movies,
      setLoading: (loading) => _isLoadingTopMovies = loading,
      setErrorMessage: (message) => _errorMessageTopMovies = message,
      setErrorIcon: (icon) => _errorIconTopMovies = icon,
    );
  }
  Future<void> fetchNowPlayingMovies() async {
    const String endpoint =
        'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1&api_key=b9d0ed699ad4607d82e0ce0ebe600ce7';

    await _fetchMovies(
      endpoint,
      setMovies: (movies) => _nowPlayingMovies = movies,
      setLoading: (loading) => _isLoadingNowPlayingMovies = loading,
      setErrorMessage: (message) => _errorMessageNowPlayingMovies = message,
      setErrorIcon: (icon) => _errorIconNowPlayingMovies = icon,
    );
  }
}
