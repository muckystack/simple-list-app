import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_list_app/src/model/category_model.dart';


class CategoryProvider {
  final _url = 'https://simple-list-muckystack.herokuapp.com';

  Future<List<CategoryModel>> getCategory() async {
    final List<CategoryModel> categories = new List();

    final resp = await http.get('${_url}/category');
    final decodeData = json.decode(resp.body)['category'];

    if (decodeData != '[]') {
      decodeData.forEach((category) {
        print('${category}');
        final prodTemp = CategoryModel.fromJson(category);

        categories.add(prodTemp);
      });
    }

    return categories;
  }

  Future<bool> deleteCategory(idCategory) async {
    final resp = await http.delete('${_url}/category/${idCategory}');
    final decodeData = json.decode(resp.body)['category'];

    getCategory();

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }

  Future<bool> createCategory(CategoryModel category) async {
    final resp = await http.post('${_url}/category', headers: {'Content-Type': 'application/json'}, body: categoryModelToJson(category));
    final decodeData = json.decode(resp.body);

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }

  Future<bool> updateCategory(CategoryModel category) async {
    final resp = await http.put('${_url}/category/${category.id}', body: categoryModelToJson(category));
    final decodeData = json.decode(resp.body)['category'];

    getCategory();

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }
}
