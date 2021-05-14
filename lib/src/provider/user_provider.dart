import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:simple_list_app/src/model/user_model.dart';
import 'package:simple_list_app/src/user_preferences/user_preferences.dart';


class UserProvider{

  final _userPref = UserPreferences();
  final _url = 'https://simple-list-muckystack.herokuapp.com';

  Future<Map<String, dynamic>> getUser(String email, String password) async{

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
    

    if(decodedData == null) return {'success': false, 'message': 'Error'};

    final status = decodedData['status']['status'];
    final userData = decodedData['user'];

    if (status == 201 && decodedData.containsKey('token')) {
      // print('save preferences');
      final userTemp = UserModel.fromJson(userData);
      user.add(userTemp);
      _userPref.token = decodedData['token'];

        return {
          'success': true, 'token': decodedData['token']
        };
    }else{
        return {
          'success': false, 'message': decodedData['message']
        };
    }

  }

  // register user
  Future<Map<String, dynamic>> registerUser(String email, String sex, String password, String confirmPassword,) async{
    
    Map<String, String> headers = {"Content-type": "application/json"};
    final encoding = Encoding.getByName('utf-8');
    final body = {
      "email"     : email,
      "sex"  : sex,
      "password"  : password,
      "passwordConfirm"  : confirmPassword
    };
    String jsonBody = json.encode(body);

    final resp = await http.post(
      '${_url}/auth/register', 
      headers: headers,
      encoding: encoding,
      body: jsonBody
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    // print(decodedData);
    if(decodedData == null) return {'success': false, 'message': 'Error'};

    final status = decodedData['status']['status'];
    final message = decodedData['message'];

    if (status == 201 
        && message == 'Se ha enviado un correo a la dirección con la que te registraste.') {
        return {
          'success' : true, 
          'token'   : decodedData['token'], 
          'message' : decodedData['message']
        };
    }else{
        return {
          'success': false, 
          'message': decodedData['message']
        };
    }

  }


}