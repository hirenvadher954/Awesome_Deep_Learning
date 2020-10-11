import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class FruitRecognizer extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
// FruitRecognizer
class _HomeState extends State<FruitRecognizer> {
  List _outputs;
  File _image;
  bool _loading = true;
  final picker = ImagePicker();
  final _title = "Fruit Recognizer";
  final _asset = 'assets/models/FruitRecognizer/watermelon.png';
  final _description = "Identify Which kind of flower is this";
  final _model = "assets/models/FruitRecognizer/model.tflite";
  final _labels = "assets/models/FruitRecognizer/labels.txt";

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _outputs = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: _model,
      labels: _labels,
    );
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(
            color: Colors.yellowAccent,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.yellow, fontSize: 25),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: _loading
                  ? Container(
                  child: Column(children: [
                    Image.asset(_asset,height: 300,width: 300,),
                    SizedBox(height: 20,)
                  ]))
                  : Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red[500],
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                      height: 200,
                      child: Container(
                        child: Image.file(
                          _image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _outputs != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        '${_outputs[0]['label']}',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                    )
                        : Container()
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  photosButton("Take A Photo", getCameraImage),
                  photosButton("Upload A Photo", getGalleryImage)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget photosButton(btnTitle, func) {
    return GestureDetector(
      onTap: func,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
            width: MediaQuery.of(context).size.width - 150,
            alignment: Alignment.center,
            height: 50,
            child: Text(
              btnTitle,
              style: TextStyle(),
            ),
            decoration: BoxDecoration(
                color: Color(0XFFE99600),
                borderRadius: BorderRadius.circular(6))),
      ),
    );
  }
}
