
import 'package:flutter/material.dart';

class UtilsHelper {

  static void showConfirmationDialog( BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }){
    final alertDialog = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <TextButton>[
        TextButton(
            onPressed: onSuccess,
            child: const Text('Yes')),
        TextButton(
            onPressed: onFailure,
            child: const Text('No'))
      ],
    );
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }
}