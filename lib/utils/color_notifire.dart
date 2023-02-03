import 'package:flutter/cupertino.dart';

import 'color.dart';

class ColorNotifire with ChangeNotifier{
  bool IsDark = false;
  set isDark(value){
    IsDark = value;
  }
  get getprimerycolor => IsDark ? darkPrimeryColor : PrimeryColor;
  get getlightblue => IsDark ? bgColor : lightblue;
  get getmediumblue => IsDark ? darkmediumblue : mediumblue;
  get getwhite => IsDark ? modeblack : modewhite;
  get getlightgrey => IsDark ? darkgrey : lightgrey;
  get getgrey => IsDark ? darkg : grey;
}