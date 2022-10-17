import 'dart:ui';

import 'package:driver_app/preferences/app_preferences.dart';
import 'package:driver_app/screens/main/order/order_details_accept_map.dart';
import 'package:driver_app/screens/main/order/order_details_map.dart';
import 'package:driver_app/screens/main/order/order_details_multi.dart';
import 'package:driver_app/screens/main/order/order_details_one.dart';
import 'package:driver_app/screens/welcom/splash_screen.dart';
import 'package:driver_app/value/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'lanugage/localString.dart';
import 'network/network_binding.dart';
import 'network/network_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().initPreferences();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
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
    Get.lazyPut(() => NetworkController());
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (contrxt, widget) {
        return GetMaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          initialBinding: NetworkBinding(),
          builder: (context, widget) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!);
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // textTheme: TextTheme(button: TextStyle(fontSize: 45.sp)),
            primaryColorLight: AppColors.appColor,
            textTheme: TextTheme(
                subtitle2: TextStyle(color: AppColors.white, fontSize: 14.sp)),

            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              // brightness: Brightness.dark,
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: false,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          translations: LocalString(),
          locale: Locale(AppPreferences().getLanguageCode,
              AppPreferences().getCountryCode),
          // home:menu()
          home: SplashScreen(),
          // home: menu(currentItem: MenuItems.Home,),
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
