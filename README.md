# Decode JSON

```dart
import 'dart:convert';

void main() {
  var rawJSON = '{"url": "https://blah.jpg", "id": 1}';
  var parsedJSON = json.decode(rawJSON);
  print(parsedJSON['url']);
}
```

# Handle JSON with Model

```dart
import 'dart:convert';

void main() {
  var rawJSON = '{"url": "https://blah.jpg", "id": 1}';
  var parsedJSON = json.decode(rawJSON);
  print(parsedJSON['url']);
  var imageModel = new ImageModel(parsedJSON['id'], parsedJSON['url']);
}

class ImageModel {
  int id; 
  String url; 
  
  ImageModel(this.id, this.url);
}
```

# Parse JSON with Model

```dart
import 'dart:convert';

void main() {
  var rawJSON = '{"url": "https://blah.jpg", "id": 1}';
  var parsedJSON = json.decode(rawJSON);
  var imageModel = new ImageModel.fromJSON(parsedJSON);
  print(imageModel.url);
}

class ImageModel {
  int id = -1; 
  String url = ""; 
  
  ImageModel(this.id, this.url);
  
  ImageModel.fromJSON(parsedJSON) {
    id = parsedJSON['id'];
    url = parsedJSON['url'];
  }
}
```

# Another way of parsing JSON

```dart
class ImageModel {
  int id = -1;
  String url = "";
  String title = "";

  ImageModel(this.id, this.url, this.title);

  // This syntax works
  // ImageModel.fromJSON(Map<String, dynamic> parsedJSON) {
  //   id = parsedJSON['id'];
  //   url = parsedJSON['url'];
  //   title = parsedJSON['title'];
  // }

  ImageModel.fromJSON(Map<String, dynamic> parsedJSON)
      : id = parsedJSON['id'],
        url = parsedJSON['url'],
        title = parsedJSON['title'];
}
```

# Async & Await

```dart
import 'dart:async';

main() async {
  print('About to fetch data...');
//   get('http://jsonplaceholder.com'')
//     .then((result) {
//       print(result);
//     });
  
  var result = await get('http://jsonplaceholder.com');
  print(result); 
 }

Future<String> get(String url) {
  return new Future.delayed(new Duration(seconds: 3), () {
    return 'Got the data!';
  });
}
```

# Entire App

### main.dart

```dart
import 'package:flutter/material.dart';
import './app.dart';

void main() {
  runApp(App());
}
```

### app.dart

```dart
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
```

### image_model.dart

```dart
class ImageModel {
  int id = -1;
  String url = "";
  String title = "";

  ImageModel(this.id, this.url, this.title);

  // This syntax works
  // ImageModel.fromJSON(Map<String, dynamic> parsedJSON) {
  //   id = parsedJSON['id'];
  //   url = parsedJSON['url'];
  //   title = parsedJSON['title'];
  // }

  ImageModel.fromJSON(Map<String, dynamic> parsedJSON)
      : id = parsedJSON['id'],
        url = parsedJSON['url'],
        title = parsedJSON['title'];
}
```

### image_list_view.dart

```dart
import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageListView extends StatelessWidget {
  final List<ImageModel> images;
  ImageListView(this.images);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return buildImage(images[index]);
      },
    );
  }

  Widget buildImage(ImageModel image) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Padding(
            child: Image.network(image.url),
            padding: EdgeInsets.only(
              bottom: 8.0,
            ),
          ),
          Text(image.title),
        ],
      ),
    );
  }
}
```