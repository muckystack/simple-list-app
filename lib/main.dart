import 'package:flutter/material.dart';
import 'package:simple_list_app/src/pages/list_page.dart';
import 'package:simple_list_app/src/pages/new_category_page.dart';
import 'package:simple_list_app/src/pages/category_page.dart';
import 'package:simple_list_app/src/pages/new_list_page.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';
import 'package:simple_list_app/src/theme/theme.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: miTema,
        title: 'Mi player musica',
        initialRoute: 'categories',
        routes: {
          'categories' : (BuildContext context) => CategoryPage(),
          'new-category' : (BuildContext context) => NewCategoryPage(),
          'list' : (BuildContext context) => ListPage(),
          'new-list' : (BuildContext context) => NewListPage(),
        },
      ),
    );
  }
}