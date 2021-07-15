import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret/provider/backend.dart';
import 'package:secret/screen/Calui.dart';
import 'package:secret/screen/GalUi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print("main");
    return ChangeNotifierProvider(
      create: (ctx) => Backend(),
      child: Consumer<Backend>(builder: (ctx, backend, child) {
        backend.firsttimef();
        return MaterialApp(
          theme: ThemeData(
              scaffoldBackgroundColor:
                  backend.dark ? Colors.black : Colors.white,
              primaryColor: Colors.grey,
              accentColor: backend.dark ? Colors.white : Colors.black,
              cardColor: backend.dark ? Colors.black : Colors.white),
          debugShowCheckedModeBanner: false,
          // routes: {
          //   "/": (ctx) => CalUi(),
          //   "/calculator": (ctx) => CalUi(),
          //   "/gallery": (ctx) => GalUi()
          // },
          home: PageTransitionSwitcher(
            reverse: backend.auth,
            duration: Duration(milliseconds: 1000),
            transitionBuilder: (child, animation, secondaryAnimation) =>
                SharedAxisTransition(
                    child: child,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal),
            child: backend.auth ? GalUi() : CalUi(),
          ),
        );
      }),
    );
  }
}
