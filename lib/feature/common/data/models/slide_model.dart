class SlideModel {
  final String id;
  final String photo_url;
  final String description;
  final String? brand;
  final String? category;

  SlideModel({required this.id, required this.photo_url, required this.description, required this.brand, required this.category});


  factory SlideModel.fromJson (Map<String , dynamic> jsonData) {
    return SlideModel (
      id: jsonData['_id'],
      photo_url:  jsonData['photo_url'],
      description:  jsonData['description'],
      brand:  jsonData['brand'],
      category:  jsonData['category'],
    );
  }
}



