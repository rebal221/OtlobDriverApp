import 'package:driver_app/screens/main/main_screens/home.dart';
import 'package:driver_app/screens/main/main_screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../value/colors.dart';
import '../../widget/app_style_text.dart';
import '../../widget/custom_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ZoomDrawerController z = ZoomDrawerController();
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

  int pageIndex = 0;

  final pages = [
    const Home(),
    const ProfileScreen(),
    // const OfferScreen(),
    // const OrderScreen(),
    // const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.blackGrey.withOpacity(.8),

      // backgroundColor: AppColors.blackGrey.withOpacity(.8),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 65.h,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: EdgeInsets.only(bottom: 5.h),
      decoration: BoxDecoration(
        color: AppColors.bottomNavigationColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: const EdgeInsets.all(0),
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ? CustomSvgImage(
                        height: 24.h,
                        width: 22.h,
                        imageName: 'home',
                        color: AppColors.appColor2,
                      )
                    : CustomSvgImage(
                        height: 24.h,
                        width: 22.h,
                        imageName: 'home',
                      ),
              ),
              pageIndex == 0
                  ? AppTextStyle(
                      name: 'الرئيسية',
                      height: 0.5,
                      fontSize: 8.sp,
                      color: AppColors.appColor2,
                    )
                  : AppTextStyle(
                      name: 'الرئيسية',
                      fontSize: 8.sp,
                      height: 0.5,
                      color: AppColors.white,
                    ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: const EdgeInsets.all(0),
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: pageIndex == 1
                    ? CustomSvgImage(
                        height: 24.h,
                        width: 22.h,
                        imageName: 'person',
                        color: AppColors.appColor2,
                      )
                    : CustomSvgImage(
                        height: 24.h,
                        width: 22.h,
                        imageName: 'person',
                      ),
              ),
              pageIndex == 1
                  ? AppTextStyle(
                      name: 'حسابي',
                      fontSize: 8.sp,
                      color: AppColors.appColor2,
                      height: 0.5,
                    )
                  : AppTextStyle(
                      name: 'حسابي',
                      fontSize: 8.sp,
                      color: AppColors.white,
                      height: 0.5,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
