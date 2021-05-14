import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/login_bloc.dart';
import 'package:simple_list_app/src/provider/user_provider.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';
import 'package:simple_list_app/src/widgets/dialog_alert.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isChecked = false;
  final userValidate = UserProvider();

  @override
  Widget build(BuildContext context) {

    final screen = MediaQuery.of(context);
    final height = screen.size.height;    
    final width = screen.size.width;  
      
    final bloc = Provider.loginBloc(context);
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.16),
            child: Column(
              children: [
                Container(
                  height: height * 0.27,
                  // color: Colors.red,
                  margin: EdgeInsets.symmetric(vertical: height * 0.05),
                  child: Image(
                    image: AssetImage('assets/Logo.png'), // si la foto tiene un valor entonces toma path si es nullo agarra la img de la dir
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(height: height * 0.02,),
                _emailField(bloc),
                SizedBox(height: height * 0.02,),
                _passwordField(bloc),
                SizedBox(height: height * 0.02,),
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
                SizedBox(height: height * 0.02,),
                _loginButton(bloc, height),
                SizedBox(height: height * 0.02,),
                FlatButton(
                  child: Text('Crear cuenta'),
                  onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                ),
              ],
            ),
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
            labelText: 'Correo',
            // border: OutlineInputBorder(),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Color.fromRGBO(179, 99, 194, 1)
            //   )
            // ),
            // labelStyle: TextStyle(
            //   color: Color.fromRGBO(179, 99, 194, 1),
            // ),
            errorText: snapshot.error
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
            labelText: 'Contraseña',
            // border: OutlineInputBorder(),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Color.fromRGBO(179, 99, 194, 1)
            //   )
            // ),
            // labelStyle: TextStyle(
            //   color: Color.fromRGBO(179, 99, 194, 1),
            // ),
            errorText: snapshot.error
          ),
          onChanged: (String value) => bloc.changePassword(value),
        );
      },
    );
  }


  Widget _loginButton(LoginBloc bloc, double height) {
    return StreamBuilder(
      stream: bloc.validateFormStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          width: double.infinity,
          height: height * 0.07,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(179, 99, 194, 1))
            ),
            child: Text('Entrar'),
            onPressed: snapshot.hasData ? () => _validateCredentials(bloc, context) : null
          ),
        );

      },
    );
  }

  _validateCredentials(LoginBloc bloc, BuildContext context) async {
    Map request =  await userValidate.getUser(bloc.email, bloc.password);

    if(request['success']){
      // print(request['token']);
      bloc.dispose();
      Navigator.pushReplacementNamed(context, 'home', arguments: request['token']);
    }else{
      myAlert(context, request['message'], 'Hubo un error');
    }


  }


}