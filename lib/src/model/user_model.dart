// To parse this JSON data, do
//
//     final UserModel = UserModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {

    String id;
    String username;
    String email;
    String password;
    String sex;
    String role;
    String status;
    String updatedAt;
    String createdAt;


    UserModel({
        this.id,
        this.username,
        this.email,
        this.password = '',
        this.sex,
        this.role,
        this.status,
        this.updatedAt,
        this.createdAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        sex: json["sex"],
        role: json["role"],
        status: json["status"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "sex": sex,
        "role": role,
        "status": status,
        "updatedAt": updatedAt,
        "createdAt": createdAt,
    };
}
