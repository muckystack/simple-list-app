import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
