import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/provider/validate_token.dart';
import 'package:simple_list_app/src/user_preferences/user_preferences.dart';

class CategoryProvider {

  final _userPref = UserPreferences();
  final _url = 'https://simple-list-muckystack.herokuapp.com';
  final _validate = ValidateToken();

  Future<List<CategoryModel>> getCategory() async {
    final List<CategoryModel> categories = new List();

    final resp = await http.get('${_url}/category', headers: {'token' : '${_userPref.token}'});
    final decodeData = json.decode(resp.body)['category'];

    // validate provider token
    if (!_validate.providerToken(resp) ){
      return categories;
    }

    if (decodeData != '[]') {
      decodeData.forEach((category) {
        final prodTemp = CategoryModel.fromJson(category);

        categories.add(prodTemp);
      });
    }

    return categories;
  }

  Future<bool> deleteCategory(idCategory) async {
    final resp = await http.delete('${_url}/category/${idCategory}', headers: {'token' : '${_userPref.token}'});
    final decodeData = json.decode(resp.body)['category'];

    // validate provider token
    if (!_validate.providerToken(resp) ){
      return false;
    }

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }

  Future<bool> createCategory(CategoryModel category) async {
    final resp = await http.post('${_url}/category',
        headers: {'Content-Type': 'application/json', 'token' : '${_userPref.token}'},
        body: categoryModelToJson(category));
    final decodeData = json.decode(resp.body);

    // validate provider token
    if (!_validate.providerToken(resp) ){
      return false;
    }

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }

  Future<bool> updateCategory(CategoryModel category) async {
    final resp = await http.put('${_url}/category/${category.id}',
        headers: {'Content-Type': 'application/json', 'token' : '${_userPref.token}'},
        body: categoryModelToJson(category));
    final decodeData = json.decode(resp.body)['category'];

    // validate provider token
    if (!_validate.providerToken(resp) ){
      return false;
    }

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }
}
