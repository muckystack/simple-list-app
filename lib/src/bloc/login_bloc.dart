import 'dart:async';
import 'package:simple_list_app/src/bloc/validations.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validations{

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  // register
  final _emailRegisterController = BehaviorSubject<String>();
  final _passwordRegisterController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final    _genderController = BehaviorSubject<int>();

  // get the streams 
  Stream<String> get emailStream    => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);
  // register page
  Stream<String> get emailRegisterStream    => _emailRegisterController.stream.transform(validateEmail);
  Stream<String> get passwordRegisterStream => _passwordRegisterController.stream.transform(validatePassword)
                                              .doOnData((String c){ 
                                                if(0 != confirmPassword.compareTo(c)){
                                                  _passwordRegisterController.addError("Las contraseñas deben ser igual");
                                                }});
  Stream<String> get confirmPasswordStream => _confirmPasswordController.stream.transform(validatePassword)
                                              .doOnData((String c){ 
                                                if(0 != passwordRegister.compareTo(c)){
                                                  _confirmPasswordController.addError("Las contraseñas deben ser igual");
                                                }});
  Stream<int> get genderStream => _genderController.stream.transform(genderValidation);


  // validate form login
  Stream<bool> get validateFormStream =>
    Observable.combineLatest2(emailStream, passwordStream, (a, b) => true);  
  // validate register form
  Stream<bool> get validateRegisterFormStream =>
    Observable.combineLatest4(emailRegisterStream, passwordRegisterStream, confirmPasswordStream, genderStream, (a, b, c, d) => true);



  // change values on text fields
  Function(String) get changeEmail  => _emailController.sink.add;
  Function(String) get changePassword  => _passwordController.sink.add;
  // register page
  Function(String) get changeEmailRegister  => _emailRegisterController.sink.add;
  Function(String) get changePasswordRegister  => _passwordRegisterController.sink.add;
  Function(String) get changeConfirmPassword  => _confirmPasswordController.sink.add;
  Function(int) get changeGender  => _genderController.sink.add;



  // the last value of email and password field
  String get email    => _emailController.value;
  String get password => _passwordController.value;
  // register page
  String get emailRegister    => _emailRegisterController.value;
  String get passwordRegister => _passwordRegisterController.value;
  String get confirmPassword => _confirmPasswordController.value;
  int get gender => _genderController.value;

  dispose(){    
    _emailController?.close();
    _passwordController?.close();
    // register page    
    _emailRegisterController?.close();
    _passwordRegisterController?.close();
    _confirmPasswordController?.close();
    _genderController?.close();
  }

}