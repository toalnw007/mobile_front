import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/show_image.dart';

Future<Null> normalDialog(
    BuildContext context, String title, String value, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: ShowImage(),
        title: Text(title),
        subtitle: Text(value + " " + message),
      ),
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Ok'),
        ),
      ],
    ),
  );
}
