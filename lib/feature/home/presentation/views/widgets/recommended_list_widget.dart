import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/data/models/movie_model.dart';
import 'package:movie_app/feature/home/presentation/manager/movie_provider.dart';
import 'package:provider/provider.dart';
import 'movie_card.dart';

class RecommendedMovieListWidget extends StatelessWidget {
  final MovieResponse? Function(MovieProvider) movieProviderSelector;
  final bool Function(MovieProvider) isLoadingSelector;
  final String? Function(MovieProvider) errorSelector;
  final IconData? Function(MovieProvider) errorIconSelector;

  const RecommendedMovieListWidget({
    required this.movieProviderSelector,
    required this.isLoadingSelector,
    required this.errorSelector,
    required this.errorIconSelector,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, _) {
        if (isLoadingSelector(provider)) {
          return const Center(child: CircularProgressIndicator());
        } else if (errorSelector(provider) != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(errorIconSelector(provider), size: 64, color: Colors.red),
                const SizedBox(height: 10),
                Text(
                  errorSelector(provider)!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        } else if (movieProviderSelector(provider) != null &&
            movieProviderSelector(provider)!.results.isNotEmpty) {
          final movies = movieProviderSelector(provider)!.results;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(movie: movie);
              },
            ),
          );
        } else {
          return const Center(child: Text("No movies found."));
        }
      },
    );
  }
}
