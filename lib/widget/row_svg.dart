import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'custom_image.dart';

class RowSvg extends StatelessWidget {
  // const RowSvg({
  //   Key? key,
  // }) : super(key: key);
  String title;

  String image;

  Color color;
  double fontSize;

  RowSvg(
      {this.fontSize = 6,
      this.color = AppColors.black,
      required this.title,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomSvgImage(
          imageName: image,
          color: color,
          height: 9.h,
          width: 9.w,
        ),
        SizedBox(
          width: 2.w,
        ),
        AppTextStyle(
          textAlign: TextAlign.center,
          name: title,
          fontSize: fontSize.sp,
          isMarai: false,

          color: color,
          fontWeight: FontWeight.w400,

          // fontWeight: FontWeight.w400,
        ),
        SizedBox(
          width: 7.w,
        ),
      ],
    );
  }
}
