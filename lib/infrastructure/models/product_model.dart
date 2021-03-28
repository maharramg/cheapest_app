import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.results,
  });

  List<Result> results;

  ProductModel copyWith({
    List<Result> results,
  }) =>
      ProductModel(
        results: results ?? this.results,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 0)
class Result {
  Result({
    this.portion,
    this.id,
    this.name,
    this.description,
    this.price,
    this.img,
    this.restaurant,
    this.created,
    this.v,
    this.count = 1,
  });

  @HiveField(0)
  int portion;

  @HiveField(1)
  String id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String description;

  @HiveField(4)
  double price;

  @HiveField(5)
  String img;

  @HiveField(6)
  String restaurant;

  @HiveField(7)
  DateTime created;

  @HiveField(8)
  int v;

  @HiveField(9)
  int count;

  Result copyWith({
    int portion,
    String id,
    String name,
    String description,
    double price,
    String img,
    String restaurant,
    DateTime created,
    int v,
    int count,
  }) =>
      Result(
        portion: portion ?? this.portion,
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        img: img ?? this.img,
        restaurant: restaurant ?? this.restaurant,
        created: created ?? this.created,
        v: v ?? this.v,
        count: count ?? this.count,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        portion: json["portion"] == null ? null : json["portion"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        img: json["img"] == null ? null : json["img"],
        restaurant: json["_restaurant"] == null ? null : json["_restaurant"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "portion": portion == null ? null : portion,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "img": img == null ? null : img,
        "_restaurant": restaurant == null ? null : restaurant,
        "created": created == null ? null : created.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
