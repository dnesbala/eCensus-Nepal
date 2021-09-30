import 'dart:convert';

Ganak ganakFromJson(String str) => Ganak.fromJson(json.decode(str));

String ganakToJson(Ganak data) => json.encode(data.toJson());

class Ganak {
  Ganak({
    this.status,
    this.token,
    this.data,
  });

  String? status;
  String? token;
  Data? data;

  factory Ganak.fromJson(Map<String, dynamic> json) => Ganak(
        status: json["status"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.email,
    this.name,
  });

  String? id;
  String? email;
  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
      };
}
