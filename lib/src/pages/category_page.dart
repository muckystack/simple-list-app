import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/category_bloc.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryBloc = Provider.of(context);
    categoryBloc.getCategory();

    return Scaffold(
      body: _crearListado(categoryBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(CategoryBloc categoryBloc) {
    return StreamBuilder(
      stream: categoryBloc.categoriesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryModel>> snapshot) {
        if (snapshot.hasData) {
          final categories = snapshot.data;
          return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int i) =>
                  _crearItem(context, categories[i], categoryBloc));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(
      BuildContext context, CategoryModel category, CategoryBloc categoryBloc) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) => categoryBloc.deleteCategory(category.id),
      child: Container(
        width: double.infinity,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(category.name),
              onTap: () => Navigator.pushNamed(context, 'list', arguments: category),
              onLongPress: () => Navigator.pushNamed(context, 'new-category', arguments: category),
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
      onPressed: () => Navigator.pushNamed(context, 'new-category'),
    );

  }
}
