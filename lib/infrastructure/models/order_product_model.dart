import 'dart:convert';

OrderProductModel orderProductModelFromJson(String str) => OrderProductModel.fromJson(json.decode(str));

String orderProductModelToJson(OrderProductModel data) => json.encode(data.toJson());

class OrderProductModel {
  OrderProductModel({
    this.foodType,
    this.foodName,
    this.restaurantId,
    this.count,
    this.amount,
  });

  String foodType;
  String foodName;
  String restaurantId;
  int count;
  int amount;

  OrderProductModel copyWith({
    String foodType,
    String foodName,
    String restaurantId,
    int count,
    int amount,
  }) =>
      OrderProductModel(
        foodType: foodType ?? this.foodType,
        foodName: foodName ?? this.foodName,
        restaurantId: restaurantId ?? this.restaurantId,
        count: count ?? this.count,
        amount: amount ?? this.amount,
      );

  factory OrderProductModel.fromJson(Map<String, dynamic> json) => OrderProductModel(
        foodType: json["foodType"] == null ? null : json["foodType"],
        foodName: json["foodName"] == null ? null : json["foodName"],
        restaurantId: json["restaurantId"] == null ? null : json["restaurantId"],
        count: json["count"] == null ? null : json["count"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "foodType": foodType == null ? null : foodType,
        "foodName": foodName == null ? null : foodName,
        "restaurantId": restaurantId == null ? null : restaurantId,
        "count": count == null ? null : count,
        "amount": amount == null ? null : amount,
      };
}
