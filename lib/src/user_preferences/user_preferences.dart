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

  get token => _userPref.getString('token') ?? '';
  set token(String value) => _userPref.setString('token', value);
  

  get userName => _userPref.getString('userName') ?? '';
  set userName(String value) => _userPref.setString('userName', value);

  get email => _userPref.getString('email') ?? '';
  set email(String value) => _userPref.setString('email', value);

  get gender => _userPref.getString('gender') ?? '';
  set gender(String value) => _userPref.setString('gender', value);


  // evaluate token
  String getInitialRoute() {
    return _userPref.getString('initialRoute') ?? 'login';
  }

  setInitialRoute( String value ) {
    _userPref.setString('initialRoute', value);
  }

  userLogIn(Map<String, dynamic> userInfo){
    String _token = userInfo['token'];
    token = _token;
    userName = userInfo['user']['username'];
    email = userInfo['user']['email'];
    gender = userInfo['user']['sex'];

  }

  userLogOut(){
    token = '';
  }


}