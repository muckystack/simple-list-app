import 'dart:async';

class Validations{

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp  regExp  = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('Correo incorrecto');
      }
      
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){

      if(password.length >= 6){
        sink.add(password);
      } else{
        sink.addError('Mínimo 6 caracteres');
      }
    }
  );
  // genre validation
  final genderValidation = StreamTransformer<int, int>.fromHandlers(
    handleData: (genre, sink){

      if(genre != null){
        sink.add(genre);
      } else{
        sink.addError('Selecciona un género');
      }
    }
  );
}