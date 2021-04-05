import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_list_app/src/bloc/list_bloc.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/singleton/bloc.dart';

class CustomAppBar extends StatelessWidget {
  final title;
  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            IconButton(
                icon: Icon(FontAwesomeIcons.chevronLeft),
                onPressed: () => Navigator.pop(context)),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 40,
            )
          ],
        ),
        height: 40,
      ),
    );
  }
}

class CustomAppBarInit extends StatelessWidget {
  const CustomAppBarInit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: Text(
                'Categorías',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 40,
            )
          ],
        ),
        height: 40,
      ),
    );
  }
}

class CustomAppBarSearch extends StatefulWidget {
  final title;
  CustomAppBarSearch(this.title);

  @override
  _CustomAppBarSearchState createState() => _CustomAppBarSearchState();
}

class _CustomAppBarSearchState extends State<CustomAppBarSearch> {
  bool buscando = false;
  Icon iconSearch = Icon(FontAwesomeIcons.search);
  CategoryModel category = new CategoryModel();

  @override
  Widget build(BuildContext context) {
    ListBloc listBloc = Provider.listBloc(context);
    final CategoryModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      category = prodData;
    }

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            IconButton(
                icon: Icon(FontAwesomeIcons.chevronLeft),
                onPressed: () => Navigator.pop(context)),
            titleAndSearch(widget.title, listBloc),
            IconButton(
                icon: iconSearch,
                onPressed: () {
                  buscando = !buscando;
                  if (buscando) {
                    iconSearch = Icon(FontAwesomeIcons.times);
                  } else {
                    listBloc.reset();
                    listBloc.getListByCategory(category);
                    iconSearch = Icon(FontAwesomeIcons.search);
                  }
                  setState(() {});
                }),
          ],
        ),
        height: 40,
      ),
    );
  }

  Widget titleAndSearch(String title, ListBloc listBloc) {
    final categoryTitle = Expanded(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );

    final listSearch = Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(hintText: 'Buscar registro'),
        onChanged: (filter) async {
          listBloc.reset();
          await listBloc.getListByCategoryAndFilter(category, filter);
        },
      ),
    ));

    return (buscando) ? listSearch : categoryTitle;
  }
}
