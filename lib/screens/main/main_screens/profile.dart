import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../value/colors.dart';
import '../../../widget/app_button.dart';
import '../../../widget/app_style_text.dart';
import '../../../widget/app_text_field_with.dart';
import '../../../widget/card_template_phone.dart';
import '../../../widget/component.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/row_edit.dart';
import '../../Auth/sing_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      // extendBodyBehindAppBar: true,
      backgroundColor: AppColors.blackGrey.withOpacity(.70),
      // 2E2E3C

      appBar: AppBar(
        elevation: 0,
        // toolbarHeight: 100.h,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(10.r),
        //         bottomRight: Radius.circular(10.r))),
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
        // leading: MenuWidget(),
        actions: [
          // MenuWidget(),
        ],

        // leading: TextButton.icon(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     icon: Icon(
        //       Icons.keyboard_arrow_right,
        //       color: Colors.white,
        //       size: 25.r,
        //     ),
        //     label: AppTextStyle(
        //       name: 'رجوع',
        //       fontSize: 10.sp,
        //     )),
      ),
      body: Column(
        // shrinkWrap: true,
        // padding: EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r)),
                    color: AppColors.appColor),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  padding: EdgeInsets.all(3.r),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.white
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.only(
                      //         bottomLeft: Radius.circular(10.r),
                      //         bottomRight: Radius.circular(10.r))),

                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(8.r),
                      ),
                  child: SizedBox(
                    height: 28.h,
                    width: 28.w,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(shape: BoxShape.circle

                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(8.r),
                          ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://www.investnational.com.au/wp-content/uploads/2016/08/person-stock-2.png',
                        // buildContext: context,
                        // height: 72.h,
                        // width: 72.w,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => shimmerCarDes(context),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextStyle(
                      name: 'أحمد علي إبراهيم',
                      fontSize: 11.sp,
                      color: AppColors.white,
                      isMarai: false,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomSvgImage(
                      imageName: 'edit',
                      height: 11.h,
                      width: 11.h,
                      color: AppColors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 28.h,
                ),
                Divider(
                  height: 15.h,
                  color: AppColors.greyC,
                ),
                RowEdit(title: 'رقم الهاتف', hint: '01020114685'),
                Divider(
                  height: 5.h,
                  color: AppColors.greyC,
                ),
                RowEdit(
                    title: 'العنوان', hint: '25 شارع الملكة - فيصل - الجيزة'),
                Divider(
                  height: 5.h,
                  color: AppColors.greyC,
                ),
                RowEdit(
                  title: 'عدد الطلبات',
                  hint: '17 طلب',
                  visible: false,
                ),
                Divider(
                  height: 5.h,
                  color: AppColors.greyC,
                ),
                RowEdit(
                  title: 'رقم الهوية',
                  hint: '475020114685',
                  visible: true,
                ),
                Divider(
                  height: 5.h,
                  color: AppColors.greyC,
                ),
                RowEdit(
                  title: 'نوع المركبة',
                  hint: 'Vespa',
                  visible: true,
                ),
                Divider(
                  height: 5.h,
                  color: AppColors.greyC,
                ),
                RowEdit(
                  title: 'رقم المركبة',
                  hint: 'ATG 478',
                  visible: false,
                ),
                Divider(
                  height: 5.h,
                  color: AppColors.greyC,
                ),
                RowEdit(
                  title: 'موديل المركبة',
                  hint: 'HYD 2545',
                  visible: false,
                ),
                Divider(
                  height: 5.h,
                  color: AppColors.greyC,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
