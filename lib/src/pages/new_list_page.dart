import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/list_bloc.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/model/list_model.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({Key key}) : super(key: key);

  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  final formKey = GlobalKey<FormState>();
  ListModel list = new ListModel();
  bool _guardando = false;
  ListBloc _listBloc = ListBloc();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CategoryModel category = new CategoryModel();

  @override
  Widget build(BuildContext context) {
    final CategoryModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      category = prodData;
    }
    return Scaffold(
      body: _createForm(),
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
              _createCode(),
              SizedBox(
                height: 50,
              ),
              _createDescription(),
              SizedBox(
                height: 50,
              ),
              _crearBoton()
            ],
          ),
        ));
  }

  Widget _createCode() {
    return TextFormField(
      initialValue: list.code,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Ingresa el nuevo código',
      ),
      onSaved: (value) => list.code = value,
      validator: (value) {
        return (value.length < 3) ? 'Ingresa el código' : null;
      },
    );
  }

  Widget _createDescription() {
    return TextFormField(
      initialValue: list.description,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nueva descripción',
      ),
      onSaved: (value) => list.description = value,
      validator: (value) {
        return (value.length < 3) ? 'Ingrese la descripció' : null;
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
    print('pero que ${list.id}');

    list.idCategory = category.id;
    print('pero que ${list}');

    if (!formKey.currentState.validate()) return;

    // ejecuta todos los metodo save que esten dentro del formulario
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (list.id == null) {
      _listBloc.createList(list);
    } else {
      _listBloc.updateList(list);
    }

    Navigator.pop(context);

    setState(() {
      _guardando = false;
    });
  }
}