import 'package:driver_app/screens/Auth/sing_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:otlob/screens/sing_in.dart';

import '../../value/colors.dart';
import '../../widget/app_button.dart';
import '../../widget/app_style_text.dart';
import '../../widget/card_template.dart';
import '../../widget/card_template_not.dart';
import '../../widget/card_template_phone.dart';
import '../../widget/card_template_phone_two.dart';
import '../../widget/custom_image.dart';
import '../reset/verfication.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TapGestureRecognizer _recognizer = TapGestureRecognizer()
    ..onTap = () => onTapRecognizer();

  void onTapRecognizer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.greyE));
    super.dispose();
  }

  final _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: AppColors.appColor
    // ));
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r))),
        backgroundColor: AppColors.appColor,
        leadingWidth: 100.w,
        leading: TextButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 25.r,
            ),
            label: AppTextStyle(
              name: 'رجوع',
              fontSize: 10.sp,
            )),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        children: [
          Align(
            alignment: Alignment.center,
            child: AppTextStyle(
              textAlign: TextAlign.center,
              name: '''من فضلك أدخل بياناتك
لانشاء حساب جديد''',
              fontSize: 14.sp,
              color: AppColors.black,
              // fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: AppTextStyle(
              textAlign: TextAlign.center,
              name: 'البريد الالكتروني',
              fontSize: 12.sp,
              color: AppColors.black,
              // fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          CardTemplateTransparent(
              prefix: 'mail', title: 'البريد الإلكتروني', controller: email),
          SizedBox(
            height: 13.h,
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: AppTextStyle(
              textAlign: TextAlign.center,
              name: 'كلمة السر',
              fontSize: 12.sp,
              color: AppColors.black,
              // fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          CardTemplateTransparent(
              prefix: 'password', title: 'كلمة السر', controller: password),
          SizedBox(
            height: 13.h,
          ),
          // Align(
          //   alignment: AlignmentDirectional.topStart,
          //   child: AppTextStyle(
          //     textAlign: TextAlign.center,
          //     name: 'رقم الهاتف',
          //     fontSize: 12.sp,
          //     color: AppColors.black,
          //     // fontWeight: FontWeight.w400,
          //   ),
          // ),
          // SizedBox(
          //   height: 7.h,
          // ),
          // CardTemplatePhone(
          //     prefix: 'call',
          //     title: 'رقم الهاتف',
          //     controller: TextEditingController()),
          // SizedBox(
          //   height: 13.h,
          // ),

          // Align(
          //   alignment: AlignmentDirectional.topStart,
          //   child: AppTextStyle(
          //     textAlign: TextAlign.center,
          //     name: 'رقم الهوية',
          //     fontSize: 12.sp,
          //     color: AppColors.black,
          //     // fontWeight: FontWeight.w400,
          //   ),
          // ),
          // SizedBox(
          //   height: 7.h,
          // ),
          // CardTemplateTransparent(
          //     prefix: 'password',
          //     visible: false,
          //     title: 'رقم الهوية',
          //     controller: TextEditingController()),
          // SizedBox(
          //   height: 13.h,
          // ),

          // Align(
          //   alignment: AlignmentDirectional.topStart,
          //   child: AppTextStyle(
          //     textAlign: TextAlign.center,
          //     name: 'العنوان',
          //     fontSize: 12.sp,
          //     color: AppColors.black,
          //     // fontWeight: FontWeight.w400,
          //   ),
          // ),
          // SizedBox(
          //   height: 7.h,
          // ),
          // CardTemplateTransparent(
          //     prefix: 'map',
          //     title: 'رقم الشارع والبناية',
          //     controller: TextEditingController()),
          // SizedBox(
          //   height: 13.h,
          // ),
          // CardTemplateTransparent(
          //     prefix: 'map',
          //     title: 'المدينة',
          //     visible: false,
          //     controller: TextEditingController()),

          // SizedBox(
          //   height: 25.h,
          // ),
          AppButton(
              title: 'انشاء حساب جديد',
              onPressed: () async {
                // Get.to(menu(currentItem: MenuItems.Home));
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email.text, password: password.text);
                  Get.to(Verfication());
                } catch (e) {
                  print(e);
                }
              }),
          SizedBox(
            height: 12.h,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'لديك حساب بالفعل؟',
                style: GoogleFonts.almarai(
                    fontWeight: FontWeight.w900,
                    color: AppColors.black,
                    fontSize: 13.sp,
                    height: 1.5),
                children: <TextSpan>[
                  const TextSpan(text: '  '),
                  TextSpan(
                      recognizer: _recognizer,
                      text: ' أدخل من هنا ',
                      style: GoogleFonts.almarai(
                          color: AppColors.appColor2,
                          fontWeight: FontWeight.w900,
                          fontSize: 13.sp,
                          height: 1.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}