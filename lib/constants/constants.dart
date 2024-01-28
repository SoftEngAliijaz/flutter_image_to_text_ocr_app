// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class AppUtils {
  static void showSnackBar(BuildContext context, String? message) {
    if (context != null && ScaffoldMessenger.of(context).mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? 'No message provided')),
      );
    }
  }

  static void showDialogMethod(
    BuildContext context,
    String title,
    String result,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
