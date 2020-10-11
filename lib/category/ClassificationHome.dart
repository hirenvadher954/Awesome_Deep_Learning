import 'package:flutter/material.dart';
import 'package:ultimate_machine_learning/category/classification/CatVsDog.dart';
import 'package:ultimate_machine_learning/category/classification/FlowerRecognizer.dart';
import 'package:ultimate_machine_learning/category/classification/FruitRecognizer.dart';

class ClassificationHome extends StatefulWidget {
  @override
  _ClassificationHomeState createState() => _ClassificationHomeState();
}

class _ClassificationHomeState extends State<ClassificationHome> {
  final _cat = 'assets/models/CatVsDog/cat.png';
  final _flower = 'assets/models/FlowerRecognizer/flower.png';

  getCatRoute() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => CatVSDog()));
  }

  getFlowerPath() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => FlowerRecognizer()));
  }
  getFruitPath() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => FruitRecognizer()));
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
            FancyCard(_cat, 'Cat Vs Dog', getCatRoute),
            FancyCard(_flower, 'Flower Recognizer', getFlowerPath),
            FancyCard(_flower, 'Fruit Recognizer', getFruitPath),

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
