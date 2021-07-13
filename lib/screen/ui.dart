import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:secret/provider/backend.dart';

class Ui extends StatefulWidget {
  @override
  _UiState createState() => _UiState();
}

class _UiState extends State<Ui> {
  var size;
  var b;
  double t = 35;
  @override
  Widget build(BuildContext context) {
    b = Provider.of<Backend>(context, listen: false);
    size = MediaQuery.of(context).size;
    print("======");
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Column(children: [
              Stack(children: [
                Consumer<Backend>(
                  builder: (ctx, b, child) => Container(
                    height: size.height * 0.2,
                    child: ListView(
                        reverse: true,
                        children: b.history.map<Widget>(
                          (e) {
                            return Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.bottomRight,
                              width: double.infinity,
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor),
                              ),
                            );
                          },
                        ).toList()),
                  ),
                ),
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
              ]),
              Consumer<Backend>(
                builder: (ctx, b, child) => Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.bottomRight,
                  height: size.height * 0.09,
                  width: double.infinity,
                  child: Text(
                    b.str(),
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 25),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            height: size.height * 0.6,
            child: b.cal.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            singlebutton3(b.cal[0]),
                            singlebutton3(b.cal[1]),
                            singlebutton3(b.cal[2]),
                            singlebutton2(b.cal[3]),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            singlebutton(b.cal[4]),
                            singlebutton(b.cal[5]),
                            singlebutton(b.cal[6]),
                            singlebutton2(b.cal[7]),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            singlebutton(b.cal[8]),
                            singlebutton(b.cal[9]),
                            singlebutton(b.cal[10]),
                            singlebutton2(b.cal[11]),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            singlebutton(b.cal[12]),
                            singlebutton(b.cal[13]),
                            singlebutton(b.cal[14]),
                            singlebutton2(b.cal[15]),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            singlebutton(b.cal[16]),
                            singlebutton(b.cal[17]),
                            singlebutton(b.cal[18]),
                            singlebutton2(b.cal[19]),
                          ],
                        ),
                      ),
                    ],
                  )
                : Text("data"),
          )
        ],
      ),
    );
  }

  Widget singlebutton(text) {
    return Expanded(
      child: InkWell(
        onTap: () {
          b.work(text);
        },
        child: Text(
          text.toString(),
          style: TextStyle(fontSize: 25, color: Theme.of(context).accentColor),
          textAlign: TextAlign.center,
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
          } else
            b.work(text);
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
