import 'package:driver_app/widget/row_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../value/colors.dart';
import 'app_style_text.dart';
import 'app_text_field.dart';

class CardGreyC extends StatelessWidget {
  const CardGreyC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        color: AppColors.whiteEB,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    AppTextStyle(
                      name: 'محمد ابراهيم',
                      isMarai: false,
                      fontSize: 9.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    AppTextStyle(
                      name: 'الأكل ممتاز جدا والسعر ممتاز والتوصيل جيد',
                      isMarai: false,
                      fontSize: 8.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    AppTextStyle(
                      name: 'اليوم  9:45 مساء',
                      fontSize: 6.sp,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                Spacer(),
                RowIcon(
                  title: '4.0',
                  fontSize: 12.sp,
                  iconData: Icons.star_rate_rounded,
                  color: AppColors.appColor,
                ),
              ],
            )),
      ),
    );
  }
}
