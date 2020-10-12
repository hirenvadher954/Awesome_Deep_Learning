import 'package:flutter/material.dart';

import 'package:ultimate_machine_learning/category/nlp/SentimentalAnalysis.dart';

class NLPHome extends StatefulWidget {
  @override
  _NLPHomeState createState() => _NLPHomeState();
}

class _NLPHomeState extends State<NLPHome> {
  final _theater = 'assets/models/NLP/theater.png';

  getSentimentalRoute() {
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => SentimentalAnalysis()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF02BB9F),
                    const Color(0xFF00CCFF),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        body: Column(
          children: [
            FancyCard(_theater, 'Sentimental Analysis', getSentimentalRoute),

          ],
        ));
  }
}

Widget FancyCard(img, text, path) {
  return GestureDetector(
    onTap: path,
    child: Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 220,
      width: double.maxFinite,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Stack(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Image.asset(
                                  img,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ],
                          ),
                          Text(text)
                        ],
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    ),
  );
}
