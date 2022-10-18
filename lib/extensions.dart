import 'package:driver_app/value/colors.dart';
import 'package:flutter/material.dart';

showSuccessBar(context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: AppColors.appColor2,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100, right: 20, left: 20),
  ));
}

showErrorBar(context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: AppColors.secondaryColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100, right: 20, left: 20),
  ));
}

checklogin(
    TextEditingController testEmail, TextEditingController testPassword) {
  String res = '';
  if (!testEmail.text.isEmailValid()) {
    res += 'Email_Error';
  }
  if (!testPassword.text.isPasswordValid()) {
    res += 'Password_Error';
  }
  return res;
}

extension EmailValidation on String {
  bool isEmailValid() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PassWordValidation on String {
  bool isPasswordValid() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);
  }
}

CutFireBaseError(String err) {
  String test;
  test = err.toString().split(' ').elementAt(0);
  print('222222222222222222222222222222222');
  print(test);
  if (test == '[firebase_auth/email-already-in-use]') {
    return 'البريد الإلكتروني المقدم قيد الاستخدام بالفعل من قبل مستخدم حالي';
  } else if (test == '[firebase_auth/user-not-found]') {
    return 'لا يوجد سجل مستخدم حالي مطابق للمعرف المقدم.';
  } else {
    return 'حدث خطأ ما يرجى المحاولة لاحقاً';
  }
}
