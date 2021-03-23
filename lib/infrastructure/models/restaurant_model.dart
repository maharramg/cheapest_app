import 'dart:convert';

List<RestaurantModel> restaurantModelFromJson(String str) => List<RestaurantModel>.from(json.decode(str).map((x) => RestaurantModel.fromJson(x)));

String restaurantModelToJson(List<RestaurantModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantModel {
  RestaurantModel({
    this.id,
    this.name,
    this.logo,
    this.foodType,
    this.created,
    this.v,
  });

  String id;
  String name;
  String logo;
  String foodType;
  DateTime created;
  int v;

  RestaurantModel copyWith({
    String id,
    String name,
    String logo,
    String foodType,
    DateTime created,
    int v,
  }) =>
      RestaurantModel(
        id: id ?? this.id,
        name: name ?? this.name,
        logo: logo ?? this.logo,
        foodType: foodType ?? this.foodType,
        created: created ?? this.created,
        v: v ?? this.v,
      );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        logo: json["logo"] == null ? null : json["logo"],
        foodType: json["food_type"] == null ? null : json["food_type"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "logo": logo == null ? null : logo,
        "food_type": foodType == null ? null : foodType,
        "created": created == null ? null : created.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
