import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_list_app/src/model/category_model.dart';

class CategoryProvider {
  final _url = 'https://simple-list-muckystack.herokuapp.com';

  Future<List<CategoryModel>> getCategory() async {
    final List<CategoryModel> categories = new List();

    final resp = await http.get('${_url}/category', headers: {'token' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2MDg1ZDU4MjYzNzBmOTAwMTVjZDQzZTEiLCJpYXQiOjE2MjAxMDA0NzQsImV4cCI6MTYyMDE4Njg3NH0.yOuDnk3O1XuXu9PN8_n3FQNhkTP98nO04LOFiHTqlNk'});
    final decodeData = json.decode(resp.body)['category'];

    if (decodeData != '[]') {
      decodeData.forEach((category) {
        final prodTemp = CategoryModel.fromJson(category);

        categories.add(prodTemp);
      });
    }

    return categories;
  }

  Future<bool> deleteCategory(idCategory) async {
    final resp = await http.delete('${_url}/category/${idCategory}');
    final decodeData = json.decode(resp.body)['category'];

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }

  Future<bool> createCategory(CategoryModel category) async {
    final resp = await http.post('${_url}/category',
        headers: {'Content-Type': 'application/json'},
        body: categoryModelToJson(category));
    final decodeData = json.decode(resp.body);

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }

  Future<bool> updateCategory(CategoryModel category) async {
    final resp = await http.put('${_url}/category/${category.id}',
        headers: {'Content-Type': 'application/json'},
        body: categoryModelToJson(category));
    final decodeData = json.decode(resp.body)['category'];

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }
}
