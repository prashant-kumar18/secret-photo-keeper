import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret/provider/backend.dart';
import 'package:secret/screen/ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool dark = true;
  void theme() {
    setState(() {
      dark = !dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Backend(),
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: dark ? Colors.black : Colors.white,
            primaryColor: Colors.grey,
            accentColor: dark ? Colors.white : Colors.black,
            cardColor: dark ? Colors.black : Colors.white),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              floatingActionButton: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: dark ? Colors.white : Colors.black,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      theme();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0),
                      child: dark
                          ? Icon(
                              Icons.mode_night,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.light_mode,
                              color: Colors.yellow,
                            ),
                    ),
                  ),
                ),
              ),
              body: Ui()),
        ),
      ),
    );
  }
}
