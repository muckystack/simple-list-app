import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:simple_list_app/src/user_preferences/user_preferences.dart';
import 'package:simple_list_app/src/utils/navigation_service.dart';

class ValidateToken{

  final _url = 'https://simple-list-muckystack.herokuapp.com';
  final _prefs = new UserPreferences();

  Future<bool> validateToken(String token) async{

    final encoding = Encoding.getByName('utf-8');
    Map<String, String> headers = {"Content-type": "application/json", "token": "${token}"};
    final resp = await http.post(
      '${_url}/auth/validatetoken', 
      headers: headers,
      encoding: encoding
    );
    final decodedData = json.decode(resp.body);
    // print(decodedData['message']);
    
    if(decodedData == null) return false;

    if(decodedData['message'] == 'Token valido'){
      _prefs.setInitialRoute('home');
      return true;

    }else{
      _prefs.setInitialRoute('login');
      return false;
    }

  }

  bool providerToken(http.Response resp){
    final Map<String, dynamic>  message = json.decode(resp.body);
    if(message.containsKey('message') && message['message'] == 'Token no valido'){
      _prefs.token = '';
      NavigationService.instance.navigateToReplacement("login");
      return false;
    }
    return true;
  }

}