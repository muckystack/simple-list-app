import 'package:flutter/material.dart';


Future myAlert(BuildContext context, String message, String title) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xff201E28),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  );
}