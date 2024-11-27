import 'dart:convert';

class MovieResponse {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      page: json['page'] ?? 0,
      results: json['results'] != null
          ? List<Movie>.from(json['results'].map((x) => Movie.fromJson(x)))
          : [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
    'page': page,
    'results': results.map((x) => x.toJson()).toList(),
    'total_pages': totalPages,
    'total_results': totalResults,
  };
}

class Movie {
  final String? backdropPath;
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String mediaType;
  final bool adult;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final String releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    try {
      return Movie(
        backdropPath: json['backdrop_path'],
        id: json['id'] ?? 0,
        title: json['title'] ?? 'Unknown Title',
        originalTitle: json['original_title'] ?? 'Unknown Original Title',
        overview: json['overview'] ?? 'No overview available',
        posterPath: json['poster_path'],
        mediaType: json['media_type'] ?? 'unknown',
        adult: json['adult'] ?? false,
        originalLanguage: json['original_language'] ?? 'N/A',
        genreIds: json['genre_ids'] != null
            ? List<int>.from(json['genre_ids'])
            : [],
        popularity: (json['popularity'] ?? 0).toDouble(),
        releaseDate: json['release_date'] ?? 'Unknown Release Date',
        video: json['video'] ?? false,
        voteAverage: (json['vote_average'] ?? 0).toDouble(),
        voteCount: json['vote_count'] ?? 0,
      );
    } catch (e) {
      throw Exception('Error parsing Movie: $e');
    }
  }

  Map<String, dynamic> toJson() => {
    'backdrop_path': backdropPath,
    'id': id,
    'title': title,
    'original_title': originalTitle,
    'overview': overview,
    'poster_path': posterPath,
    'media_type': mediaType,
    'adult': adult,
    'original_language': originalLanguage,
    'genre_ids': genreIds,
    'popularity': popularity,
    'release_date': releaseDate,
    'video': video,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };
}