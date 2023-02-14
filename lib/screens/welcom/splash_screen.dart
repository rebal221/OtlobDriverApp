import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/preferences/app_preferences.dart';
import 'package:driver_app/screens/Auth/sing_in.dart';
import 'package:driver_app/screens/main/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../value/colors.dart';
import '../../widget/custom_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.black.withOpacity(.6),
    ));
    super.dispose();
  }

  final _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    user = _auth.currentUser;
    FirebaseFirestore.instance
        .collection('drivers')
        .where('uid', isEqualTo: AppPreferences().getData(key: 'uid'))
        .get()
        .then((value) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.black.withOpacity(.6),
      ));
      // TODO: implement initState
      Future.delayed(const Duration(seconds: 2), () {
        // Get.offAll(() => const SignIn());
      });
      if (user != null) {
        Get.to(() => HomePage(),
            transition: Transition.fade,
            duration: Duration(milliseconds: 1000));
      } else {
        Get.to(() => SignIn(),
            transition: Transition.fade,
            duration: Duration(milliseconds: 1000));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black.withOpacity(.6),
      body: Stack(
        children: [
          // CustomSvgImage(imageName: 'splash_backgroud',height: 50.h,),
          CustomPngImage(
            imageName: 'splash',
            height: double.infinity,
            width: double.infinity,
            boxFit: BoxFit.cover,
          ),
          Container(
            color: AppColors.black.withOpacity(.6),
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: CustomSvgImage(
              imageName: 'logo',
              height: 122.h,
              width: 99.w,
            ),
          ),
        ],
      ),
    );
  }
}
