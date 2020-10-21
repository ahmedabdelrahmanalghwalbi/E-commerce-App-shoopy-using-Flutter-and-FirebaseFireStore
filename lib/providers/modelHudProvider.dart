import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier{
  bool showed=false;
  ShowedTrue(){
    showed=true;
    notifyListeners();
  }
  ShowedFalse(){
    showed=false;
    notifyListeners();
  }
}