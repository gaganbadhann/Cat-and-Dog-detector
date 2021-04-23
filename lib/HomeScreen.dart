import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool _leading = true;
  // file _image;
  File _image;
  List _output;
  final picker = ImagePicker();
  detactImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.6,
      imageStd: 127.6,
    );
    setState(() {
      _leading = false;
      _output = output;
    });
  }

  pickimage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
      // _image = File(Image.path);
    });
    detactImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
      // _image = File(Image.path);
    });
    detactImage(_image);
  }

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Cat & Dog Detect",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 70,
          ),
          Center(
            child: _leading
                ? Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      "assets/catdog.png",
                      color: Colors.red,
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(height: 300, child: Image.file(_image)),
                        SizedBox(
                          height: 20,
                        ),
                        _output != null
                            ? Text(
                                "${_output[0]['label']}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            : Container(
                                child: SizedBox(
                                  height: 10,
                                ),
                              )
                      ],
                    ),
                  ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 140,
              child: Text(
                "Pick From Gallery",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(30)),
            ),
            onTap: () {
              pickGalleryImage();
            },
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 140,
              child: Text(
                "Capture By Camera",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(30)),
            ),
            onTap: () {
              pickimage();
            },
          )
        ],
      ),
    );
  }
}
