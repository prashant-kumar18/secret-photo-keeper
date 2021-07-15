import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:secret/provider/backend.dart';

class CalUi extends StatefulWidget {
  @override
  _UiState createState() => _UiState();
}

class _UiState extends State<CalUi> {
  var size;
  var b;
  bool editmode = false;
  double t = 35;
  @override
  void initState() {
    b = Provider.of<Backend>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print("cal");
    return SafeArea(
      child: Consumer<Backend>(
        builder: (ctx, backend, child) {
          return Scaffold(
            floatingActionButton: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundColor: backend.dark ? Colors.white : Colors.black,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    backend.darkmode();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0),
                    child: backend.dark
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
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Column(children: [
                      Stack(
                        children: [
                          Container(
                            height: size.height * 0.2,
                            child: backend.firstime
                                ? Center(
                                    child: Text(
                                      backend.firsttimemessage,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context).accentColor),
                                    ),
                                  )
                                : backend.editmode
                                    ? Center(
                                        child: Text(
                                          backend.editmessage,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      )
                                    : ListView(
                                        reverse: true,
                                        children: backend.history.map<Widget>(
                                          (e) {
                                            return Container(
                                              padding: EdgeInsets.all(20),
                                              alignment: Alignment.bottomRight,
                                              width: double.infinity,
                                              child: Text(
                                                e.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                          ),
                          Container(),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Theme.of(context).cardColor,
                                    Theme.of(context).cardColor.withOpacity(0)
                                  ]),
                            ),
                            height: size.height * 0.2,
                          ),
                        ],
                      ),
                      Consumer<Backend>(
                        builder: (ctx, b, child) => Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.bottomRight,
                          height: size.height * 0.09,
                          width: double.infinity,
                          child: Text(
                            b.str(),
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    height: size.height * 0.6,
                    child: backend.cal.isNotEmpty
                        ? Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    singlebuttonAC(backend.cal[0]),
                                    singlebutton3(backend.cal[1]),
                                    singlebutton3(backend.cal[2]),
                                    singlebutton2(backend.cal[3]),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    singlebutton(backend.cal[4]),
                                    singlebutton(backend.cal[5]),
                                    singlebutton(backend.cal[6]),
                                    singlebutton2(backend.cal[7]),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    singlebutton(backend.cal[8]),
                                    singlebutton(backend.cal[9]),
                                    singlebutton(backend.cal[10]),
                                    singlebutton2(backend.cal[11]),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    singlebutton(backend.cal[12]),
                                    singlebutton(backend.cal[13]),
                                    singlebutton(backend.cal[14]),
                                    singlebutton2(backend.cal[15]),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    singlebutton(backend.cal[16]),
                                    singlebutton(backend.cal[17]),
                                    singlebutton(backend.cal[18]),
                                    singlebutton2(backend.cal[19]),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Text("data"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget singlebuttonAC(text) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(200),
        radius: 20,
        splashColor: Colors.white,
        onTap: () {
          b.work(text);
        },
        onLongPress: () {
          Provider.of<Backend>(context, listen: false).editmodef();
        },
        child: CircleAvatar(
          radius: 35,
          backgroundColor:
              b.editmode ? Colors.red : Theme.of(context).primaryColor,
          child: Text(
            text.toString(),
            style:
                TextStyle(fontSize: 25, color: Theme.of(context).accentColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget singlebutton(text) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(200),
        onTap: () {
          b.work(text);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0),
          radius: 35,
          child: Text(
            text.toString(),
            style:
                TextStyle(fontSize: 25, color: Theme.of(context).accentColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget singlebutton2(text) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(200),
        radius: 20,
        splashColor: Colors.white,
        onTap: () {
          if (text == "x") {
            b.work("*");
          } else {
            b.work(text);
          }
        },
        child: CircleAvatar(
          radius: 35,
          backgroundColor: Theme.of(context).accentColor,
          child: Text(
            text.toString(),
            style: TextStyle(
                fontSize: 25, color: Theme.of(context).scaffoldBackgroundColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget singlebutton3(text) {
    if (text == "<-") {
      return Expanded(
        child: AnimatedContainer(
          duration: Duration(microseconds: 300),
          child: GestureDetector(
            onTap: () {
              setState(() {
                t = 70;
              });
              Future.delayed(Duration(milliseconds: 60))
                  .then((value) => setState(() {
                        t = 35;
                      }));

              b.work(text);
            },
            child: CircleAvatar(
                maxRadius: t,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.backspace,
                  color: Theme.of(context).accentColor,
                )),
          ),
        ),
      );
    }
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(200),
        onTap: () {
          b.work(text);
        },
        child: CircleAvatar(
          maxRadius: 35,
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            text.toString(),
            style:
                TextStyle(fontSize: 25, color: Theme.of(context).accentColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
