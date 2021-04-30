import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      // width: 250,
                      // color: Colors.red,
                      padding: EdgeInsets.only(top: 80, bottom: 80),
                      child: Image(
                        image: AssetImage('assets/Logo.png'), // si la foto tiene un valor entonces toma path si es nullo agarra la img de la dir
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(179, 99, 194, 1)
                          )
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(179, 99, 194, 1),
                        ),
                        labelText: 'Correo',
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(179, 99, 194, 1)
                          )
                        ),
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(179, 99, 194, 1),
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      // color: Colors.redAccent,
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.only(left: - double.infinity),
                        activeColor: Color.fromRGBO(179, 99, 194, 1),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Recordar sesión'),
                        value: _isChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _isChecked = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(179, 99, 194, 1))
                        ),
                        child: Text('Entrar'),
                        onPressed: (){},
                      ),
                    ),
                    SizedBox(height: 20,),
                    FlatButton(
                      child: Text('Crear cuenta'),
                      onPressed: () =>{},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}