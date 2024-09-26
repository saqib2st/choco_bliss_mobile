import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLoader {
  static void showLoader({String? text}) {
    Get.generalDialog(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return text?.isNotEmpty ?? false?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 8),
          Text(text ?? '',style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              decoration: TextDecoration.none
          ),)
        ],
      )
          : const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  static void hideLoader() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
