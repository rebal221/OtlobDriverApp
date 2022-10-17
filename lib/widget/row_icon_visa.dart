import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'app_text_field_no_border.dart';
import 'app_text_field_with.dart';
import 'custom_image.dart';

class RowIconVisa extends StatelessWidget {
  String title;

  String hint;
  bool visible;
  bool enable ;
  double fontSize ;

  RowIconVisa({
    this.enable = true,
    this.fontSize = 10,
    this.visible = true, required this.title, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AppTextStyle(
            name: title,
            fontSize: fontSize.sp,
            color: AppColors.black,
            isMarai: false,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.w,),

        CustomSvgImage(
          imageName: 'visa',
          height: 11.h,
          width: 14.w,
        ),
        SizedBox(width: 5.w,),

        CustomSvgImage(
          imageName: 'master',
          height: 15.h,
          width: 14.w,
        ),
        SizedBox(width: 5.w,),

        CustomSvgImage(
          imageName: 'cash',
          height: 15.h,
          width: 14.w,
        ),
        Spacer(flex: 2,),





      ],
    );
  }
}
