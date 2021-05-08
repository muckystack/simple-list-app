import 'package:flutter/material.dart';
import 'package:simple_list_app/src/pages/home_page.dart';
import 'package:simple_list_app/src/pages/list_page.dart';
import 'package:simple_list_app/src/pages/login_page.dart';
import 'package:simple_list_app/src/pages/new_category_page.dart';
import 'package:simple_list_app/src/pages/category_page.dart';
import 'package:simple_list_app/src/pages/new_list_page.dart';
import 'package:simple_list_app/src/provider/validate_token.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';
import 'package:simple_list_app/src/theme/theme.dart';
import 'package:simple_list_app/src/user_preferences/user_preferences.dart';
import 'package:simple_list_app/src/utils/navigation_service.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  // validate token
  final token = ValidateToken();
  await token.validateToken(prefs.token);
  
  runApp(MyApp());

} 
 
class MyApp extends StatelessWidget {

  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        navigatorKey: NavigationService.instance.navigationKey,
        debugShowCheckedModeBanner: false,
        theme: miTema,
        initialRoute: prefs.getInitialRoute(),
        routes: {
          'categories' : (BuildContext context) => CategoryPage(),
          'new-category' : (BuildContext context) => NewCategoryPage(),
          'list' : (BuildContext context) => ListPage(),
          'new-list' : (BuildContext context) => NewListPage(),
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}