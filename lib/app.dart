import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'dart:convert';
import 'widgets/image_list_view.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  fetchImage() async {
    counter++;
    var response = await get(
        Uri.parse("https://jsonplaceholder.typicode.com/photos/$counter"));
    var imageModel = ImageModel.fromJSON(json.decode(response.body));
    setState(() {
      images.add(imageModel);
    });
  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            fetchImage();
          },
        ),
        appBar: AppBar(
          title: Text(
            "HelloWorld!!!!!",
          ),
        ),
        body: ImageListView(images),
      ),
    );
  }
}
