import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/model/list_model.dart';
import 'package:simple_list_app/src/provider/validate_token.dart';
import 'package:simple_list_app/src/user_preferences/user_preferences.dart';

class ListProvider {
  final _userPref = UserPreferences();
  final _url = 'https://simple-list-muckystack.herokuapp.com';
  final _validate = ValidateToken();

  Future<List<ListModel>> getListByCategory(CategoryModel category) async {
    final List<ListModel> categories = new List();

    final resp = await http.get('${_url}/list/${category.id}', headers: {'token' : '${_userPref.token}'});
    final decodeData = json.decode(resp.body)['list'];

    // validate provider token
    if (!_validate.providerToken(resp) ){
      return categories;
    }

    if (decodeData != '[]') {
      decodeData.forEach((list) {
        final prodTemp = ListModel.fromJson(list);

        categories.add(prodTemp);
      });
    }

    return categories;
  }
  
  Future<List<ListModel>> getListByCategoryAndFilter(CategoryModel category, String filter) async {
    final List<ListModel> categories = new List();

    final resp = await http.get('${_url}/list/${category.id}?filter=${filter}', headers: {'token' : '${_userPref.token}'});
    final decodeData = json.decode(resp.body)['list'];

    // validate provider token
    if (!_validate.providerToken(resp) ){
      return categories;
    }

    if (decodeData != '[]') {
      decodeData.forEach((list) {
        final prodTemp = ListModel.fromJson(list);

        categories.add(prodTemp);
      });
    }

    return categories;
  }

  Future<bool> deleteList(idList) async {
    final resp = await http.delete('${_url}/list/${idList}', headers: {'token' : '${_userPref.token}'});
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

  Future<bool> createList(ListModel list) async {
    final resp = await http.post('${_url}/list',
        headers: {'Content-Type': 'application/json', 'token' : '${_userPref.token}'},
        body: listModelToJson(list));
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

  Future<bool> updateList(ListModel list) async {
    final resp = await http.put('${_url}/list/${list.id}', 
        headers: {'Content-Type': 'application/json', 'token' : '${_userPref.token}'},
        body: listModelToJson(list));

    final decodeData = json.decode(resp.body)['list'];
    // print(decodeData);
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
