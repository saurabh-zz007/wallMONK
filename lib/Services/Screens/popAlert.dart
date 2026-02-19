import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class dialogService {
  Future<bool> showDialogBox(
    String title,
    String description,
    String confirmText,
  ) async {
    final bool? result = await Get.dialog<bool>(
      barrierDismissible: false,
      AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () =>
                Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () =>
                Get.back(result: true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
