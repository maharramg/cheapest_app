import 'dart:convert';

AccountModel accountModelFromJson(String str) => AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    this.id,
    this.username,
    this.email,
    this.created,
    this.v,
  });

  String id;
  String username;
  String email;
  DateTime created;
  int v;

  AccountModel copyWith({
    String id,
    String username,
    String email,
    DateTime created,
    int v,
  }) =>
      AccountModel(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        created: created ?? this.created,
        v: v ?? this.v,
      );

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json["_id"] == null ? null : json["_id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "created": created == null ? null : created.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
