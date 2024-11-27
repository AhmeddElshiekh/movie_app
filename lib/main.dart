import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'feature/home/presentation/manager/bottom_nav_bar_provider.dart';
import 'feature/home/presentation/manager/movie_provider.dart';
import 'feature/home/presentation/views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:  const HomeView(),
    );
  }
}
