import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/data/models/movie_model.dart';
import 'package:movie_app/feature/home/presentation/views/home_details_view.dart';

class Top10MovieCard extends StatelessWidget {
  final Movie movie;
  int index;

  Top10MovieCard({required this.movie, super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeDetailView(movie: movie),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              CachedNetworkImage(
                width: 200,
                imageUrl: movie.posterPath != null
                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    : '',
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover,
              ),
              Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Container(
                    width: 220,
                  ),
                  Text(
                    '${index + 1}',
                    style: const TextStyle(
                        fontSize: 80,
                        fontFamily: 'AlfaSlabOne',
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
