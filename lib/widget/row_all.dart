import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';

class RowAll extends StatelessWidget {
  String mainTitle;
  String subTitle;
  void Function() onPressed;

  RowAll(
      {required this.mainTitle,
      required this.subTitle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppTextStyle(
          name: mainTitle,
          color: AppColors.white,
          fontSize: 8.sp,
          isMarai: false,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          width: 40.w,
        ),
        InkWell(
          onTap: onPressed,
          child: AppTextStyle(
            name: subTitle,
            color: AppColors.white,
            fontSize: 8.sp,
            isMarai: false,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
