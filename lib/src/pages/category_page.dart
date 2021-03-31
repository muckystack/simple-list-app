import 'package:flutter/material.dart';
import 'package:simple_list_app/src/bloc/category_bloc.dart';
import 'package:simple_list_app/src/bloc/list_bloc.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';
import 'package:simple_list_app/src/widgets/custom_appbar.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryBloc = Provider.of(context);
    final listBloc = Provider.listBloc(context);
    categoryBloc.getCategory();

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomAppBarInit(),
          Expanded(child: _crearListado(categoryBloc, listBloc))
        ],
      ),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(CategoryBloc categoryBloc, ListBloc listBloc) {
    return StreamBuilder(
      stream: categoryBloc.categoriesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryModel>> snapshot) {
        if (snapshot.hasData) {
          final categories = snapshot.data;
          return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int i) =>
                  _crearItem(context, categories[i], categoryBloc, listBloc));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(
      BuildContext context, CategoryModel category, CategoryBloc categoryBloc, ListBloc listBloc) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) async {
        await categoryBloc.deleteCategory(category.id);
      },
      child: Container(
        width: double.infinity,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                category.name,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                listBloc.reset();
                Navigator.pushNamed(context, 'list', arguments: category);
              },
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
