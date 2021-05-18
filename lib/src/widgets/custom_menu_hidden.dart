import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:simple_list_app/src/user_preferences/user_preferences.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  SimpleHiddenDrawerController controller;
  final _userPref = UserPreferences();

  @override
  void didChangeDependencies() {
    controller = SimpleHiddenDrawerController.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(179, 99, 194, 0.8),
                  Color.fromRGBO(179, 99, 194, 0.3),
                  Color.fromRGBO(179, 99, 194, 0.0),
                  Color.fromRGBO(179, 99, 194, 0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              // color: Colors.grey,
              width: 300,
              child: Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: AssetImage('assets/Logo.png'),
                          // foregroundColor: Colors.white,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 16,),
                        Text(_userPref.email,
                          style: TextStyle(fontSize: 17,),
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          title: Text('Categorías'),
                          onTap: () {
                            controller.setSelectedMenuPosition(0);
                          },
                        ),
                        ListTile(
                          title: Text('Opcion 2'),
                          onTap: () => controller.setSelectedMenuPosition(1),
                        ),
                        ListTile(
                          title: Text('Opcion 3'),
                          onTap: () => controller.setSelectedMenuPosition(2),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      reverse: true,
                      children: [
                        ListTile(
                          title: Text('Log Out'),
                          onTap: (){
                            _userPref.userLogOut();
                            Navigator.pushReplacementNamed(context, 'login');
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}