import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/model/list_model.dart';

class ListProvider {
  final _url = 'https://simple-list-muckystack.herokuapp.com';

  Future<List<ListModel>> getListByCategory(CategoryModel category) async {
    final List<ListModel> categories = new List();

    final resp = await http.get('${_url}/list/${category.id}');
    final decodeData = json.decode(resp.body)['list'];

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

    final resp = await http.get('${_url}/list/${category.id}?filter=${filter}');
    final decodeData = json.decode(resp.body)['list'];

    if (decodeData != '[]') {
      decodeData.forEach((list) {
        final prodTemp = ListModel.fromJson(list);

        categories.add(prodTemp);
      });
    }

    return categories;
  }

  Future<bool> deleteList(idList) async {
    final resp = await http.delete('${_url}/list/${idList}');
    final decodeData = json.decode(resp.body)['category'];

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }

  Future<bool> createList(ListModel list) async {
    final resp = await http.post('${_url}/list',
        headers: {'Content-Type': 'application/json'},
        body: listModelToJson(list));
    final decodeData = json.decode(resp.body);

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }

  Future<bool> updateList(ListModel list) async {
    final resp = await http.put('${_url}/list/${list.id}', 
        headers: {'Content-Type': 'application/json'},
        body: listModelToJson(list));

    final decodeData = json.decode(resp.body)['list'];

    if (decodeData != '[]') {
      return true;
    }

    return false;
  }
}
