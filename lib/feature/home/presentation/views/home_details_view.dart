import 'package:flutter/material.dart';
import '../../../../generated/assets.dart';
import '../../data/models/movie_model.dart';

class HomeDetailView extends StatelessWidget {
  final Movie movie;

  const HomeDetailView({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
            child: Image.asset(
              Assets.imagesImg1,
              height: 32,
              width: 32,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.backdropPath != null)
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              )
            else
              Container(
                height: 250,
                color: Colors.grey,
                child: const Center(
                  child: Text(
                    "No Image Available",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: Text(
                movie.title ?? 'No Title',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: Image.asset(Assets.imagesImg2,height: 15,),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: MaterialButton(
                height: 56,
                onPressed: () {},
                color: Colors.white,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(width: 5),
                    Text('Play Movie',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: MaterialButton(
                height: 56,
                onPressed: () {},
                color: Colors.grey.shade700,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 5),
                    Text('Download',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(height: 5),
                    Text('Watchlist', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.group, color: Colors.white),
                    SizedBox(height: 5),
                    Text('Watch Party', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.share, color: Colors.white),
                    SizedBox(height: 5),
                    Text('Share', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie.overview ?? 'No description available.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'IMDb: ',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    movie.voteAverage.toString() ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    movie.releaseDate ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    '1 h 44 min',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(Assets.imagesImg3,height: 15,),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(Assets.imagesImg4,height: 15,),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(Assets.imagesImg5,height: 15,),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
