import 'dart:convert';

SampleModel sampleModelFromJson(String str) => SampleModel.fromJson(json.decode(str));

String sampleModelToJson(SampleModel data) => json.encode(data.toJson());

class SampleModel {
  SampleModel({
   required this.id,
    required this.title,
    required this.price,
    required  this.description,
    required this.category,
    required this.image,
  });

  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;


  factory SampleModel.fromJson(Map<String, dynamic> json) => SampleModel(
    id: json["id"],
    title: json["title"],
    price: json["price"].toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
  };
}

