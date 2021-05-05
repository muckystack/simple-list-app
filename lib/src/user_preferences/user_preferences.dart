import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{

  static final UserPreferences _instancia = new UserPreferences._internal();
  
  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _userPref;

  initPrefs() async {
    _userPref = await SharedPreferences.getInstance();
  }

  get token{
    return _userPref.getString('token') ?? '';
  }

  set token(String value){
    _userPref.setString('token', value);    
  }


  // evaluate token
  String getInitialRoute() {
    return _userPref.getString('initialRoute') ?? 'login';
  }

  setInitialRoute( String value ) {
    _userPref.setString('initialRoute', value);
  }


}