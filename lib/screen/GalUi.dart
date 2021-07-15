import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret/provider/backend.dart';

class GalUi extends StatefulWidget {
  @override
  _GalUiState createState() => _GalUiState();
}

class _GalUiState extends State<GalUi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Consumer<Backend>(
          builder: (ctx, backend, child) => ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).accentColor)),
            child: Text(
              "Calculator",
              style: TextStyle(color: Theme.of(context).cardColor),
            ),
            onPressed: () {
              backend.authf();
            },
          ),
        ),
        body: Column(children: [
          SizedBox(height: 60),
          Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder(
              future: Provider.of<Backend>(context, listen: false).images(),
              builder: (ctx, snapshot) {
                print("1");
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data.isNotEmpty) {
                  return GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.5,
                    mainAxisSpacing: 10,
                    children: snapshot.data.map<Widget>((e) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onLongPress: () {
                            print("object");
                          },
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return Hero(
                                  tag: e.toString(),
                                  child: Container(child: Image.file(e)));
                            }));
                          },
                          child: Hero(
                            tag: e.toString(),
                            child: Container(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.8),
                              width: 400,
                              height: 400,
                              child: Image.file(
                                e,
                                height: 200,
                                width: 200,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text("Empty, Add Images ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          )));
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
                child: Icon(Icons.photo),
                onPressed: () {
                  Provider.of<Backend>(context, listen: false)
                      .pickimage(context);
                }),
          ),
        ]),
      ),
    );
  }
}
