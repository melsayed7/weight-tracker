import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Loading ... '),
              ),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.of(context).pop();
}

void showMessage(BuildContext context, String message, String posActionTitle,
    Function posAction,
    {String? nagActionTitle, Function? negAction}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  posAction(context);
                },
                child: Text(posActionTitle))
          ],
        );
      });
}
