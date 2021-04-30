import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/login_bloc.dart';
import 'package:simple_list_app/src/provider/user_provider.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    
    final bloc = Provider.loginBloc(context);
    // final peticion = UserProvider();
    // peticion.getUser('user@gmail.com', '123456');
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
                    _emailField(bloc),
                    SizedBox(height: 20,),
                    _passwordField(bloc),
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


  Widget _emailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return TextField(
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
          onChanged: (String value) => bloc.changeEmail(value),
        );
      },
    );
  }



  Widget _passwordField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return TextField(
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
            counterText: snapshot.data
          ),
          onChanged: (String value) => bloc.changePassword(value),
        );
      },
    );
  }



}