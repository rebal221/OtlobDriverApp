import 'package:driver_app/screens/main/home_screen.dart';
import 'package:driver_app/screens/main/main_screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:otlob/screens/sing_in.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../value/colors.dart';
import '../../widget/app_button.dart';
import '../../widget/app_style_text.dart';
import '../../widget/card_template.dart';
import '../../widget/card_template_not.dart';
import '../../widget/card_template_phone.dart';
import '../../widget/custom_image.dart';
import '../Auth/sing_in.dart';

class Verfication extends StatefulWidget {
  const Verfication({Key? key}) : super(key: key);

  @override
  State<Verfication> createState() => _VerficationState();
}

class _VerficationState extends State<Verfication> {
  late final TapGestureRecognizer _recognizer = TapGestureRecognizer()
    ..onTap = () => onTapRecognizer();

  void onTapRecognizer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  final _auth = FirebaseAuth.instance;
  User? user;
  bool? isverfiyemail;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  void initState() {
    user = _auth.currentUser;

    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    // vefriyEmail();
    super.initState();
    setState(() {
      isverfiyemail = user!.emailVerified;
    });
  }

  vefriyEmail() async {
    if (user!.emailVerified == false) {
      await user!.sendEmailVerification();
      print('Verification email has been sent successfully');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'تم ارسال كود التحقق بنجاح',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 101, 250, 121),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            right: 20,
            left: 20),
      ));
    } else {
      print('Verification email was not sent successfully');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'لم يرسل ايميل التحقق بنجاح',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 235, 48, 23),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            right: 20,
            left: 20),
      ));
    }
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
              child: Icon(
                Icons.done,
                color: Colors.green.shade400,
                size: 75.sp,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AppTextStyle(
                textAlign: TextAlign.center,
                name: 'مرحباً ${''}\nتم تسجيل الحساب بنجاح ',
                fontSize: 14.sp,
                color: AppColors.black,
                // fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(
              height: 40.h,
            ),
            // Spacer(),
            // Align(
            //   alignment: Alignment.center,
            //   child: Container(
            //     width: 150,
            //     height: 150,
            //     child: Image.asset(
            //       'images/register_successfully.png',
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.center,
            //   child: AppTextStyle(
            //     textAlign: TextAlign.center,
            //     name: 'شكراً لك\nيرجى التحقق من بريدك الألكتروني',
            //     fontSize: 14.sp,
            //     color: AppColors.black,
            //     // fontWeight: FontWeight.w400,
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            // Pinput(
            //   length: 6,
            //   errorTextStyle: const TextStyle(
            //       fontSize: 25.0, color: Color.fromARGB(255, 15, 15, 15)),
            //   focusNode: _pinPutFocusNode,
            //   controller: _pinPutController,

            //   // eachFieldWidth: 40.0,
            //   // eachFieldHeight: 55.0,
            //   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            //   androidSmsAutofillMethod:
            //       AndroidSmsAutofillMethod.smsUserConsentApi,
            //   submittedPinTheme: defaultPinTheme,
            //   focusedPinTheme: defaultPinTheme,
            //   followingPinTheme: defaultPinTheme,
            //   pinAnimationType: PinAnimationType.fade,
            //   onSubmitted: (pin) async {
            //     try {
            //       // await FirebaseAuth.instance
            //       //     .signInWithCredential(PhoneAuthProvider.credential(
            //       //     verificationId: _verificationCode, smsCode: pin))
            //       //     .then((value) async {
            //       //   if (value.user != null) {
            //       Navigator.pushAndRemoveUntil(
            //           context,
            //           MaterialPageRoute(builder: (context) => Home()),
            //           (route) => false);
            //       //   }
            //       // });
            //     } catch (e) {
            //       FocusScope.of(context).unfocus();
            //       // showSnackBar(context: context, content: 'invalid OTP');
            //     }
            //   },
            // ),
            // SizedBox(
            //   height: 5.h,
            // ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       AppTextStyle(
            //         textAlign: TextAlign.center,
            //         name: '''إعادة إرسال الرمز خلال''',
            //         fontSize: 10.sp,
            //         fontWeight: FontWeight.w400,
            //         color: AppColors.black,
            //         // fontWeight: FontWeight.w400,
            //       ),
            //       SizedBox(
            //         width: 5.w,
            //       ),
            //       Countdown(
            //         seconds: 20,
            //         build: (_, double time) => RichText(
            //           text: TextSpan(
            //               text: '',
            //               style: TextStyle(
            //                 fontSize: 10.sp,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColors.appColor2,
            //                 // color: Theme.of(context).inputDecorationTheme.labelStyle?.color
            //               ),
            //               children: <TextSpan>[
            //                 TextSpan(
            //                   text: time.toString(),
            //                   style: GoogleFonts.cairo(
            //                     color: AppColors.appColor2,
            //                     // letterSpacing: letterSpacing,
            //                     // wordSpacing: wordSpacing,
            //                     fontWeight: FontWeight.w400,
            //                     fontSize: 13.sp,
            //                   ),
            //                 ),
            //                 TextSpan(
            //                   text: '  ثانية',
            //                   style: GoogleFonts.cairo(
            //                     color: AppColors.black,
            //                     // letterSpacing: letterSpacing,
            //                     // wordSpacing: wordSpacing,
            //                     fontWeight: FontWeight.w400,
            //                     fontSize: 12.sp,
            //                   ),
            //                 )
            //               ]),
            //         ),
            //         onFinished: () {},
            //       ),
            //     ],
            //   ),
            // ),
            Spacer(),
            AppButton(
                title: 'تسجيل الدخول',
                onPressed: () {
                  // Get.to(menu(currentItem: MenuItems.Home));
                  Get.to(SignIn());
                  // vefriyEmail();
                }),
          ],
        ),
      ),
    );
  }
}
