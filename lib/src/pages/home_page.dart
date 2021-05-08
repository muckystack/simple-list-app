import 'package:flutter/material.dart';

import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:simple_list_app/src/pages/category_page.dart';

import 'package:simple_list_app/src/widgets/custom_menu_hidden.dart';


 
 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      menu: Menu(),
      screenSelectedBuilder: (position, controller) {
        
        Widget screenCurrent;
        
        switch(position){
          case 0 : screenCurrent = CategoryPage(); break; // default page
          case 1 : screenCurrent = Container(color: Colors.deepPurple,child: Center(child: Text('container'))); break;
          case 2 : screenCurrent = Container(color: Colors.cyanAccent,child: Center(child: Text('container'))); break;
        }
        return screenCurrent;
      },
    );
  }
}