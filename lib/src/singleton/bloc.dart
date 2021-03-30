import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/category_bloc.dart';
import 'package:simple_list_app/src/bloc/list_bloc.dart';

class Provider extends InheritedWidget {

  final _categoryBloc = new CategoryBloc();
  final _listBloc = new ListBloc();



  static Provider _instancia;

  factory Provider({Key key, Widget child}) {

    if(_instancia == null) {

      _instancia = new Provider._internal(key: key, child: child);

    }

    return _instancia;

  }

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);



  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CategoryBloc of (BuildContext context) {

    return context.dependOnInheritedWidgetOfExactType<Provider>()._categoryBloc;

  }
  
  
  static ListBloc listBloc (BuildContext context) {

    return context.dependOnInheritedWidgetOfExactType<Provider>()._listBloc;

  }

}