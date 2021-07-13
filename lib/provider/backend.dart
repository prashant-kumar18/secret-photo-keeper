import 'package:flutter/cupertino.dart';

import 'package:function_tree/function_tree.dart';

class Backend with ChangeNotifier {
  bool dark = false;
  final cal = [
    "AC",
    "C",
    "<-",
    "/",
    1,
    2,
    3,
    "+",
    4,
    5,
    6,
    "-",
    7,
    8,
    9,
    "x",
    ".",
    0,
    "00",
    "="
  ];
  var history = [];
  var temp = [];

  void work(value) {
    String str = "";
    if (value == "=") {
      if (temp.isNotEmpty) {
        for (var i = 0; i < temp.length; i++) {
          str += temp[i].toString();
        }
        try {
          var c = str.interpret();
          history.add(c);
          Iterable inReverse = history.reversed;
          var InReverse = inReverse.toList();
          history = InReverse;
          temp = [];
          temp.add(c);
          notifyListeners();
        } catch (e) {}
      }
    } else if (value == "<-") {
      if (temp.isNotEmpty) {
        temp.removeLast();

        notifyListeners();
      }
    } else if (value == "AC") {
      temp.clear();
      history.clear();
      notifyListeners();
    } else if (value == "C") {
      temp.clear();
      notifyListeners();
    } else {
      temp.add(value);
      notifyListeners();
    }
  }

  String str() {
    var s = "";
    for (int i = 0; i < temp.length; i++) {
      s = s + temp[i].toString();
    }
    return s;
  }
}
