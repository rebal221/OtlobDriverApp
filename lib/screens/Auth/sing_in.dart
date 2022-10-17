import 'package:driver_app/screens/Auth/sign_up.dart';
import 'package:driver_app/screens/main/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../value/colors.dart';
import '../../widget/app_button.dart';
import '../../widget/app_button_icon.dart';
import '../../widget/app_style_text.dart';
import '../../widget/card_template.dart';
import '../../widget/custom_image.dart';
import '../reset/reset_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late final TapGestureRecognizer _recognizer = TapGestureRecognizer()
    ..onTap = () => onTapRecognizer();

  void onTapRecognizer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  final _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: AppColors.greyE
    // ));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: AppColors.greyE
    // ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: AppColors.greyE
    // ));
    return Scaffold(
      // backgroundColor: AppColors.greyE.withOpacity(.5),
      body: Stack(
        children: [
          // CustomSvgImage(imageName: 'splash_backgroud',height: 50.h,),
          CustomPngImage(
            imageName: 'login',
            height: double.infinity,
            width: double.infinity,
            boxFit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  AppColors.black.withOpacity(.25),
                  AppColors.black,
                ])),
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: ListView(
              padding: EdgeInsets.only(
                  right: 16.w, left: 16.w, top: 0.h, bottom: 20.h),
              shrinkWrap: true,
              children: [
                CustomSvgImage(
                  imageName: 'logo',
                  height: 122.h,
                  width: 115.w,
                ),
                SizedBox(
                  height: 140.h,
                ),
                AppTextStyle(
                  name: 'البريد الالكتروني',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CardTemplate(
                    prefix: 'mail',
                    title: 'البريد الإلكتروني',
                    controller: email),
                SizedBox(
                  height: 13.h,
                ),
                AppTextStyle(
                  name: 'كلمة السر',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CardTemplate(
                    prefix: 'password',
                    title: 'كلمة السر',
                    controller: password),
                SizedBox(
                  height: 5.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(ResetPassword());
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: AppTextStyle(
                      name: 'نسيت كلمة السر؟',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                AppButton(
                    title: 'تسجيل دخول',
                    onPressed: () async {
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                        if (user != null) {
                          print('Login successfully');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                              'اهلاً بعودتك',
                              style: TextStyle(color: Colors.black),
                            ),
                            backgroundColor: AppColors.appColor2,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height - 100,
                                right: 20,
                                left: 20),
                          ));
                          Get.to(HomePage());
                        }
                      } catch (e) {
                        print(e);
                        print('Login Faild');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            'حدث خطأ ما, يرجى المحاولة مرة أخرى',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Color.fromARGB(255, 235, 48, 23),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 100,
                              right: 20,
                              left: 20),
                        ));
                      }
                    }),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'ليس لديك حساب ؟',
                      style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w900,
                          color: AppColors.white,
                          fontSize: 13.sp,
                          height: 1.5),
                      children: <TextSpan>[
                        const TextSpan(text: '  '),
                        TextSpan(
                            recognizer: _recognizer,
                            text: 'سجل الآن',
                            style: GoogleFonts.almarai(
                                color: AppColors.appColor2,
                                fontWeight: FontWeight.w900,
                                fontSize: 13.sp,
                                height: 1.5)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
