import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
mixin Helpers {
  void showSnackBar(
      {required BuildContext context,
        required String content,
        bool error = false}) {
    if(!error) {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message:
          content,
        ),
      );
    }else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          content,
        ),
      );
    }
    //
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(content, style:  const TextStyle(color: Colors.white),),
    //     backgroundColor: error ? Colors.red : Colors.green,
    //     behavior: SnackBarBehavior.floating,
    //     duration: const Duration(seconds: 3),
    //   ),
    // );
  }
}
