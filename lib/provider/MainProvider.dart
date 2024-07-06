import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  bool _isLog = false;
  bool get isLog => _isLog;

  int _temp = 0, _humed = 0, _dust = 0, _air = 0;
  int get temp => _temp;
  int get humed => _humed;
  int get dust => _dust;
  int get air => _air;
  
  void updateData(int t, int h, int d, int a) {
    _temp = t;
    _humed = h;
    _dust = d;
    _air = a;
    notifyListeners();
  }

  void IsLogged(bool isLog) async {
    _isLog = isLog;
    notifyListeners();
  }
}
