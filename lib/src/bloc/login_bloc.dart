import 'dart:async';
import 'package:simple_list_app/src/bloc/validations.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validations{

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // get the streams 
  Stream<String> get emailStream    => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  Stream<bool> get validateFormStream =>
    Observable.combineLatest2(emailStream, passwordStream, (a, b) => true);


  // change values on text fields
  Function(String) get changeEmail  => _emailController.sink.add;
  Function(String) get changePassword  => _passwordController.sink.add;

  // the last value of email and password field
  String get email    => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}