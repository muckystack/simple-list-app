import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/login_bloc.dart';
import 'package:simple_list_app/src/provider/user_provider.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';
import 'package:simple_list_app/src/widgets/dialog_alert.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final userValidate = UserProvider();
  int _gender = null;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    final height = screen.size.height;    
    final width = screen.size.width;  

    // userValidate.registerUser("user@gmail.com", "MEN", "123456", "123456");
    final blocRegister = Provider.loginBloc(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.16),
            child: Column(
              children: [
                SizedBox(height: height * 0.02,),
                Container(
                  // height: height * 0.27,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: height * 0.06),
                  // color: Color.fromRGBO(255, 0, 0, 0.1),
                  child: Text(
                    'Creemos tu cuenta',
                    style: Theme.of(context).textTheme.headline4
                  ),
                ),
                _emailField(blocRegister),
                SizedBox(height: height * 0.02,),
                _genderField(blocRegister),
                SizedBox(height: height * 0.02,),
                _passwordField(blocRegister),
                SizedBox(height: height * 0.02,),
                _confirmPasswordField(blocRegister),
                SizedBox(height: height * 0.06,),
                _registerButton(blocRegister, height),
                SizedBox(height: height * 0.02,),
                FlatButton(
                  child: Text('Ya tengo una cuenta'),
                  onPressed: () {
                    blocRegister.dispose();
                    Navigator.pushReplacementNamed(context, 'login');
                  } 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _genderField(LoginBloc blocRegister) {
    // blocRegister.changeGender(null);
    return StreamBuilder(
      stream: blocRegister.genderStream,
      builder: (context, snapshot) {
        // print(snapshot);
        return DropdownButtonFormField(
          elevation: 5,
          isExpanded: true,
          value: _gender,
          hint: Text('Selecciona un género'),
          items: [
            DropdownMenuItem(
              child: Text("Hombre"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Mujer"),
              value: 2
            ),
          ],
          onChanged: (value) {
            setState(() {
              _gender = value;
              blocRegister.changeGender(value);
            });
          },
          autovalidateMode: AutovalidateMode.always,
          validator: (value) => value == null ? snapshot.error : null,
        );
      }
    );
  }

  Widget _emailField(LoginBloc blocRegister) {
    return StreamBuilder(
      stream: blocRegister.emailRegisterStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // print(snapshot);
        return TextField(
          decoration: InputDecoration(
            labelText: 'Correo',
            errorText: snapshot.error
          ),
          onChanged: (String value) => blocRegister.changeEmailRegister(value),
        );
      },
    );
  }

  Widget _passwordField(LoginBloc blocRegister) {
    return StreamBuilder(
      stream: blocRegister.passwordRegisterStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return TextField(
          onTap: () {
            if(_gender == null){
              blocRegister.changeGender(null);
            }
          },
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            errorText: snapshot.error
          ),
          onChanged: (String value) => blocRegister.changePasswordRegister(value),
        );
      },
    );
  }

  Widget _confirmPasswordField(LoginBloc blocRegister) {
    return StreamBuilder(
      stream: blocRegister.confirmPasswordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirmar contraseña',
            errorText: snapshot.error,
          ),
          onChanged: (String value) => blocRegister.changeConfirmPassword(value),
        );
      },
    );
  }

  Widget _registerButton(LoginBloc blocRegister, double height) {
    return StreamBuilder(
      stream: blocRegister.validateRegisterFormStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          width: double.infinity,
          height: height * 0.07,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(179, 99, 194, 1))
            ),
            child: Text('Crear cuenta'),
            onPressed: snapshot.hasData ? () => _validateCredentials(blocRegister, context) : null
          ),
        );

      },
    );
  }

  _validateCredentials(LoginBloc blocRegister, BuildContext context) async {
    String tempGender;
    blocRegister.gender == 1 ? tempGender = 'MEN' : tempGender = 'WOMAN';
    Map request =  await userValidate.registerUser(
      blocRegister.emailRegister, 
      tempGender,
      blocRegister.passwordRegister,
      blocRegister.confirmPassword,
    );

    if(request['success']){

      // print(request['token']);
      blocRegister.dispose();
      Navigator.pushReplacementNamed(context, 'login');
      myAlert(context, request['message'], 'Verifica tu correo para completar tu registro.');
    }else{
      myAlert(context, request['message'], 'Mensaje');
    }


  }
}