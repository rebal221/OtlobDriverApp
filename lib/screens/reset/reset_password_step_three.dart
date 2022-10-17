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
import '../../widget/custom_image.dart';
import '../Auth/sing_in.dart';

class ResetPasswordStepThree extends StatefulWidget {
  const ResetPasswordStepThree({Key? key}) : super(key: key);

  @override
  State<ResetPasswordStepThree> createState() => _ResetPasswordStepThreeState();
}

class _ResetPasswordStepThreeState extends State<ResetPasswordStepThree> {
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
        SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    super.dispose();
  }

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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Column(
          // padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          children: [
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: AppTextStyle(
                textAlign: TextAlign.center,
                name:
                    'تم أرسال الرابط الى بريدك الألكتروني بنجاح يرجى أعادة تعيين كلمة السر و تسجيل الدخول مرة أخرى',
                fontSize: 14.sp,
                color: AppColors.black,
                // fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 57.h,
            ),
            Spacer(),
            AppButton(
                title: 'تسجيل الدخول',
                onPressed: () {
                  Get.to(() => SignIn(),
                      transition: Transition.fade,
                      duration: Duration(milliseconds: 1000));
                }),
          ],
        ),
      ),
    );
  }
}
