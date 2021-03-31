import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/category_bloc.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';
import 'package:simple_list_app/src/widgets/custom_appbar.dart';

class NewCategoryPage extends StatefulWidget {
  const NewCategoryPage({Key key}) : super(key: key);

  @override
  _NewCategoryPageState createState() => _NewCategoryPageState();
}

class _NewCategoryPageState extends State<NewCategoryPage> {
  final formKey = GlobalKey<FormState>();
  CategoryModel category = new CategoryModel();
  bool _guardando = false;
  CategoryBloc _categoryBloc;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _categoryBloc = Provider.of(context);

    final CategoryModel prodData = ModalRoute.of(context).settings.arguments;
    String titleAppBar = 'Nueva categoría';
    if (prodData != null) {
      category = prodData;
      titleAppBar = 'Edita categoría';
    }


    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomAppBar(titleAppBar),
          Expanded(child: _createForm()),
        ],
      ),
    );
  }

  Widget _createForm() {
    return Container(
        height: double.infinity,
        padding: EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _createName(),
              SizedBox(
                height: 50,
              ),
              _crearBoton()
            ],
          ),
        ));
  }

  Widget _createName() {
    return TextFormField(
      initialValue: category.name,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre de nueva categoría',
      ),
      onSaved: (value) => category.name = value,
      validator: (value) {
        return (value.length < 3) ? 'Ingrese el nombre de la categoria' : null;
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(169, 80, 162, 1.0),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    print('pero que ${category.id}');

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (category.id == null) {
      _categoryBloc.createCategory(category);
    } else {
      _categoryBloc.updateCategory(category);
    }

    Navigator.pop(context);

    setState(() {
      _guardando = false;
    });
  }
}
