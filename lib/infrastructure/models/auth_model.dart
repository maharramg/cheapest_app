import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    this.token,
    this.errors,
  });

  String token;
  List<Error> errors;

  AuthModel copyWith({
    String token,
    List<Error> errors,
  }) =>
      AuthModel(
        token: token ?? this.token,
        errors: errors ?? this.errors,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"] == null ? null : json["token"],
        errors: json["errors"] == null ? null : List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "errors": errors == null ? null : List<dynamic>.from(errors.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    this.msg,
  });

  String msg;

  Error copyWith({
    String msg,
  }) =>
      Error(
        msg: msg ?? this.msg,
      );

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
      };
}
