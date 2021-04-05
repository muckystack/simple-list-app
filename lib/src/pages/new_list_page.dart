import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/list_bloc.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/model/list_model.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';
import 'package:simple_list_app/src/utils/arguments_util.dart';
import 'package:simple_list_app/src/widgets/custom_appbar.dart';
import 'package:simple_list_app/src/widgets/loading.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({Key key}) : super(key: key);

  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  final formKey = GlobalKey<FormState>();
  ListModel list = new ListModel();
  bool _guardando = false;
  ListBloc _listBloc;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CategoryModel category = new CategoryModel();

  @override
  Widget build(BuildContext context) {
    _listBloc = Provider.listBloc(context);
    final ListOfCategory prodData = ModalRoute.of(context).settings.arguments;
    String titleAppBar = 'Nuevo listado';

    if (prodData.category != null) category = prodData.category;
    if (prodData.list != null) {
      list = prodData.list;
      titleAppBar = 'Edita listado';
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
          child: ListView(
            children: [
              _createCode(),
              SizedBox(
                height: 50,
              ),
              _createDescription(),
              SizedBox(
                height: 50,
              ),
              _crearBoton(),
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
        return (value.length < 1) ? 'Ingresa el código' : null;
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
    list.idCategory = category.id;

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    buildShowDialog(context);

    if (list.id == null) {
      await _listBloc.createList(list, category);
    } else {
      await _listBloc.updateList(list, category);
    }

    Navigator.pop(context);
    Navigator.pop(context);

    setState(() {
      _guardando = false;
    });
  }
}
