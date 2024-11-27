import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/presentation/views/widgets/movie_bannar_widget.dart';
import 'package:movie_app/feature/home/presentation/views/widgets/recommended_list_widget.dart';
import 'package:movie_app/feature/home/presentation/views/widgets/section_header.dart';
import 'package:movie_app/feature/home/presentation/views/widgets/top_10_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../generated/assets.dart';
import '../manager/bottom_nav_bar_provider.dart';
import '../manager/movie_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final movieProvider = Provider.of<MovieProvider>(context, listen: false);
      movieProvider.fetchTopMovies();
      movieProvider.fetchRecommendedMovies();
      movieProvider.fetchNowPlayingMovies();
    });

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Assets.imagesImg,
          height: 100,
          width: 78,
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
            child: Image.asset(
              Assets.imagesImg1,
              height: 32,
              width: 32,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: MovieBannerWidget(
              movieProviderSelector: (provider) => provider.nowPlayingMovies,
              isLoadingSelector: (provider) =>
                  provider.isLoadingNowPlayingMovies,
              errorSelector: (provider) =>
                  provider.errorMessageNowPlayingMovies,
              errorIconSelector: (provider) =>
                  provider.errorIconNowPlayingMovies,
              pageController: pageController,
            ),
          ),
          const SizedBox(height: 10),

          Consumer<MovieProvider>(
            builder: (context, provider, child) {
              return SmoothPageIndicator(
                controller: pageController,
                count: provider.nowPlayingMovies?.results.length ?? 0,
                effect: const ScrollingDotsEffect(
                  activeDotColor: Colors.white,
                  dotHeight: 7,
                  dotWidth: 7,
                ),
              );
            },
          ),
          const SizedBox(height: 15),

          const SectionHeader(title: 'Recommended Movies'),
          Expanded(
            child: RecommendedMovieListWidget(
              movieProviderSelector: (provider) => provider.recommendedMovies,
              isLoadingSelector: (provider) => provider.isLoadingRecommended,
              errorSelector: (provider) => provider.errorMessageRecommended,
              errorIconSelector: (provider) => provider.errorIconRecommended,
            ),
          ),

          const SectionHeader(title: 'Top 10 Movies In India'),
          Expanded(
            child: Top10MovieListWidget(
              movieProviderSelector: (provider) => provider.topMovies,
              isLoadingSelector: (provider) => provider.isLoadingTopMovies,
              errorSelector: (provider) => provider.errorMessageTopMovies,
              errorIconSelector: (provider) => provider.errorIconTopMovies,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<BottomNavBarProvider>().currentIndex,
        onTap: (index) {
          context.read<BottomNavBarProvider>().changeIndexNavBar(index: index);
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_download_outlined), label: 'Download'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Find'),
        ],
      ),
    );
  }
}






