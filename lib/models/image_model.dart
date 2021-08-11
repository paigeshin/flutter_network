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
