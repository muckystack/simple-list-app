import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/category_bloc.dart';
import 'package:simple_list_app/src/bloc/list_bloc.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/model/list_model.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {


  CategoryModel category = new CategoryModel();

  @override
  Widget build(BuildContext context) {
    final listBloc = Provider.listBloc(context);

    final CategoryModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData != null) {
      category = prodData;
    }

    listBloc.getListByCategory(category);

    return Scaffold(
      body: _crearListado(listBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(ListBloc listBloc) {
    return StreamBuilder(
      stream: listBloc.listStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ListModel>> snapshot) {
        if (snapshot.hasData) {
          final list = snapshot.data;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int i) =>
                  _crearItem(context, list[i], listBloc));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(
      BuildContext context, ListModel list, ListBloc listBloc) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) => listBloc.deleteList(list.id),
      child: Container(
        width: double.infinity,
        height: 110,
        // color: Colors.blue,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(list.code),
              subtitle: Text(list.description),
              // onTap: () => Navigator.pushNamed(context, 'list', arguments: list),
            ),
            Divider()
          ],
        )
      )
    );
  }

   _crearBoton(BuildContext context) {

    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(169, 80, 162, 1.0),
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'new-list', arguments: category),
    );

  }
}
