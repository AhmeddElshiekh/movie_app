import 'package:flutter/cupertino.dart';


class BottomNavBarProvider with ChangeNotifier {
  int _currentIndex = 0;


  int get currentIndex => _currentIndex;

  void changeIndexNavBar ({required int index}){
    _currentIndex = index;
    notifyListeners();

  }

}




