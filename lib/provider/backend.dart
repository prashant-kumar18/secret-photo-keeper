import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class Backend with ChangeNotifier {
  bool dark = false;
  bool auth = false;
  bool editmode = false;
  var editmessage = "Enter sequence for Secret ";
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
  var code = [];
  var resetting = false;
  var codestring = "";
  var firstime = true;
  var firsttimemessage = "Hi,To set and reset Sequence Hold 'AC'";

  void darkmode() {
    dark = !dark;
    notifyListeners();
  }

  void authf() {
    auth = !auth;
    temp.clear();
    history.clear();
    editmode = false;
    notifyListeners();
  }

  void editmodef() {
    print(codestring != null);
    if (codestring != null) {
      temp.clear();
      history.clear();
      resetting = !resetting;
      editmode = !editmode;
      print(editmode);
      editmessage = "Enter Previous Sequence to Reset";
      notifyListeners();
    } else {
      print("object");
      firstime = false;
      editmode = !editmode;
      notifyListeners();
    }
  }

  void reset(str) {
    if (codestring == str) {
      editmessage = "Now Enter new Sequence";
      temp.clear();
      code.clear();
      resetting = false;

      notifyListeners();
    } else {
      editmessage = "Wrong Sequence,Retry";
      temp.clear();
      code.clear();
      notifyListeners();
    }
  }

  Future firsttimef() async {
    var sharedpref = await SharedPreferences.getInstance();
    // sharedpref.remove("firsttime");
    // sharedpref.remove("code");

    codestring = sharedpref.getString("code");
    print(codestring);

    if (sharedpref.containsKey("firsttime")) {
      firstime = false;
    } else {
      await sharedpref.setBool("firsttime", false);
    }

    return;
  }

  // Future user() async {}
  void work(value) async {
    try {
      var sharedpref = await SharedPreferences.getInstance();
      String str = "";

      if (value == "=") {
        if (temp.isNotEmpty) {
          for (var i = 0; i < temp.length; i++) {
            str += temp[i].toString();
          }
          if (resetting == true) {
            print("====reset");
            reset(str);

            return;
          }
          if (code.isNotEmpty) {
            codestring = "";
            for (var i = 0; i < code.length; i++) {
              codestring += code[i].toString();
            }
            sharedpref.setString("code", codestring);

            // if (str == codestring && resetting == false) {
            //   print("resetting" + resetting.toString());

            //   authf();
            //   return;
            // }
          }
          if (str == codestring && resetting == false) {
            authf();
            return;
          }
          if (editmode) {
            print("here3");
            editmessage = "";
            for (var i = 0; i < code.length; i++) {
              editmessage += code[i].toString() + " ";
            }
            editmessage = "Your secret code is " + editmessage;
            temp.clear();
            history.clear();
            notifyListeners();
            code.clear();
            return;
          }
          print("======");
          var c = str.interpret();
          history.add(c);
          Iterable inReverse = history.reversed;
          var InReverse = inReverse.toList();
          history = InReverse;
          temp = [];
          temp.add(c);
          notifyListeners();
        }
      } else if (value == "<-") {
        if (temp.isNotEmpty) {
          if (editmode) code.removeLast();
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
        if (editmode) code.add(value);
        temp.add(value);
        notifyListeners();
      }
    } catch (e) {
      print("error :-> " + e.toString());
    }
  }

  String str() {
    var s = "";
    for (int i = 0; i < temp.length; i++) {
      s = s + temp[i].toString();
    }
    return s;
  }

  Future<void> pickimage(BuildContext context) async {
    try {
      final List<AssetEntity> assets = await AssetPicker.pickAssets(
        context,
        textDelegate: EnglishTextDelegate(),
        maxAssets: 20,
        pickerTheme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            bottomAppBarColor: Colors.white,
            buttonColor: Colors.white,
            primaryColor: Colors.white),
      );

      if (assets != null) {
        var path = "/storage/emulated/0/Secret";
        Directory dir3 = Directory(path);

        if (!await dir3.exists()) {
          dir3.create();
        }

        for (var item in assets) {
          File file = await item.file;

          var name = item.title.split(".")[0].trim();
          await file.copy((join(path.trim(), "$name.txt")));
          File tfile =
              File("/storage/emulated/0/" + item.relativePath + item.title);

          await tfile.delete();
          imageCache.clear();
          notifyListeners();
        }
      }
    } catch (e) {
      print("error");
    }
  }

  Future<List<File>> images() async {
    List<File> list = [];
    try {
      final path = "/storage/emulated/0/Secret";
      Directory dir = Directory(path.trim());

      var temp = dir.listSync();

      if (await dir.exists()) {
        dir.create();
      }
      for (int i = 0; i < temp.length; i++) {
        var path = temp[i].toString().split(":")[1].substring(2).split(".")[0];

        list.add(File(path + ".txt"));
      }
      return list;
    } catch (e) {
      print(e);
    }
    return list;
  }
}
