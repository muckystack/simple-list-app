import 'dart:convert';

ListModel listModelFromJson(String str) => ListModel.fromJson(json.decode(str));

String listModelToJson(ListModel data) => json.encode(data.toJson());

class ListModel {
    ListModel({
        this.id,
        this.code,
        this.description,
        this.idCategory,
        this.status,
    });

    String id;
    String code;
    String description;
    String idCategory;
    String status;

    factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        id: json["id"],
        code: json["code"],
        description: json["description"],
        idCategory: json["idCategory"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "description": description,
        "idCategory": idCategory,
        "status": status,
    };
}
