import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';

class RowIcon extends StatelessWidget {
  // const RowIcon({
  //   Key? key,
  // }) : super(key: key);
  String title;
  double fontSize;

  IconData iconData;
  Color color;

  RowIcon({
  this.fontSize = 6,
    required this.title, required this.iconData, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 9.r,
          color: color
        ),
        SizedBox(
          width: 2.w,
        ),
        AppTextStyle(
          textAlign: TextAlign.center,
          name: title,
          isMarai: false,
          fontWeight: FontWeight.w400,


          fontSize: fontSize.sp,
          color: AppColors.white,
          // fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
