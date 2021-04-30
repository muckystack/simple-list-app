import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:simple_list_app/src/model/user_model.dart';


class UserProvider{

  final _url = 'https://simple-list-muckystack.herokuapp.com';
  String _token = '';

  Future<List<UserModel>> getUser(String email, String password) async{

    final List<UserModel> user = [];
    
    Map<String, String> headers = {"Content-type": "application/json"};
    final body = {
      "email"     : email,
      "password"  : password
    };
     String jsonBody = json.encode(body);
     final encoding = Encoding.getByName('utf-8');

    final resp = await http.post(
      '${_url}/auth/login', 
      headers: headers,
      body: jsonBody,
      encoding: encoding
    );
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    

    if(decodedData == null) return [];

    final status = decodedData['status']['status'];
    final userData = decodedData['user'];

    if (status == 201 && decodedData.containsKey('token')) {
      print('entendido');
      final userTemp = UserModel.fromJson(userData);
      user.add(userTemp);

      _token = decodedData['token'];

    }

    return  user;
  }


}