import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class SentimentalAnalysis extends StatefulWidget {
  @override
  _SentimentalAnalysisState createState() => _SentimentalAnalysisState();
}

class APIService {
  static const _api_key = 'zWTFqmVyZs3h9Vc4dtlUFQNMtE3HcWX9wrXrecXykPk';
  static const String _baseUrl = 'https://apis.paralleldots.com/v5/emotion';

  Future<Sentimental> post({@required Map<String, String> query}) async {
    final response = await http.post(_baseUrl, body: {
      "api_key": _api_key,
      "text": query['text'],
    });

    if (response.statusCode == 200) {
      print("Success" + response.body);
      print(json.decode(response.body));
      return Sentimental.fromJson(json.decode(response.body));
    } else {
      throw Exception('Check Your Internet Connection');
    }
  }
}

class Sentimental {
  final String emotions;

  Sentimental({this.emotions});

  factory Sentimental.fromJson(Map<String, dynamic> json) {
    double happy = json['emotion']['happy'];
    double sad = json['emotion']['sad'];
    double fear = json['emotion']['fear'];
    double excited = json['emotion']['excited'];
    double indifferent = json['emotion']['indifferent'];
    var dicti = {
      happy: "happy",
      sad: "sad",
      fear: "fear",
      excited: "excited",
      indifferent: "indifferent"
    };
    List d3 = [happy, sad, fear, excited, indifferent];
    final emotions = d3.reduce((curr, next) => curr > next ? curr : next);
    print(dicti[emotions]);
    return Sentimental(emotions: dicti[emotions]);
  }
}

class _SentimentalAnalysisState extends State<SentimentalAnalysis> {
  bool _loading = true;
  final myController = TextEditingController();

  APIService apiService = APIService();
  Future<Sentimental> analysis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.004, 1],
                colors: [Color(0XFFe100ff), Color(0XFF8E2DE2)])),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
              ),
              Text(
                'Sentimental Analysis',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 28),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7)
                    ]),
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: _loading
                            ? Container(
                                width: 300,
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: myController,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 21),
                                          labelText: "Enter A Search Term"),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                print(myController.text);
                                analysis = apiService
                                    .post(query: {'text': myController.text});
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 180,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 17),
                              decoration: BoxDecoration(
                                  color: Color(0XFF56ab2f),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Text(
                                'Find Emotions',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FutureBuilder<Sentimental>(
                              future: analysis,
                              builder: (context, snapshot) {
                                print(snapshot.data);
                                if (snapshot.hasData) {
                                  return Text(
                                    'Prediction is: ' + snapshot.data.emotions,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return CircularProgressIndicator();
                              })
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
