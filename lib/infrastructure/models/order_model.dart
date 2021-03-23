// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.order,
    this.message,
  });

  Order order;
  String message;

  OrderModel copyWith({
    Order order,
    String message,
  }) =>
      OrderModel(
        order: order ?? this.order,
        message: message ?? this.message,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "order": order == null ? null : order.toJson(),
        "message": message == null ? null : message,
      };
}

class Order {
  Order({
    this.status,
    this.id,
    this.totalAmount,
    this.food,
    this.user,
    this.created,
    this.v,
  });

  String status;
  String id;
  double totalAmount;
  List<Food> food;
  String user;
  DateTime created;
  int v;

  Order copyWith({
    String status,
    String id,
    double totalAmount,
    List<Food> food,
    String user,
    DateTime created,
    int v,
  }) =>
      Order(
        status: status ?? this.status,
        id: id ?? this.id,
        totalAmount: totalAmount ?? this.totalAmount,
        food: food ?? this.food,
        user: user ?? this.user,
        created: created ?? this.created,
        v: v ?? this.v,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        status: json["status"] == null ? null : json["status"],
        id: json["_id"] == null ? null : json["_id"],
        totalAmount: json["total_amount"] == null ? null : json["total_amount"].toDouble(),
        food: json["_food"] == null ? null : List<Food>.from(json["_food"].map((x) => Food.fromJson(x))),
        user: json["_user"] == null ? null : json["_user"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "_id": id == null ? null : id,
        "total_amount": totalAmount == null ? null : totalAmount,
        "_food": food == null ? null : List<dynamic>.from(food.map((x) => x.toJson())),
        "_user": user == null ? null : user,
        "created": created == null ? null : created.toIso8601String(),
        "__v": v == null ? null : v,
      };
}

class Food {
  Food({
    this.id,
    this.foodType,
    this.restaurantId,
    this.count,
    this.amount,
  });

  String id;
  String foodType;
  String restaurantId;
  int count;
  double amount;

  Food copyWith({
    String id,
    String foodType,
    String restaurantId,
    int count,
    double amount,
  }) =>
      Food(
        id: id ?? this.id,
        foodType: foodType ?? this.foodType,
        restaurantId: restaurantId ?? this.restaurantId,
        count: count ?? this.count,
        amount: amount ?? this.amount,
      );

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["_id"] == null ? null : json["_id"],
        foodType: json["foodType"] == null ? null : json["foodType"],
        restaurantId: json["restaurantId"] == null ? null : json["restaurantId"],
        count: json["count"] == null ? null : json["count"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "foodType": foodType == null ? null : foodType,
        "restaurantId": restaurantId == null ? null : restaurantId,
        "count": count == null ? null : count,
        "amount": amount == null ? null : amount,
      };
}
