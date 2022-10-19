import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'app_text_field_no_border.dart';
import 'app_text_field_with.dart';
import 'custom_image.dart';

class RowEdit extends StatelessWidget {
  String title;

  String hint;
  bool visible;
  bool enable;
  double fontSize;
  final void Function() onPress;

  RowEdit(
      {this.enable = true,
      this.fontSize = 10,
      this.visible = true,
      required this.title,
      required this.hint,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: AppTextStyle(
            name: title,
            fontSize: fontSize.sp,
            color: AppColors.white,
            isMarai: false,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          flex: 2,
          child: AppFieldNoBorder(
            enable: false,
            hint: hint,
            controller: TextEditingController(),
          ),
        ),
        Visibility(
          visible: visible,
          child: GestureDetector(
            onTap: onPress,
            child: CustomSvgImage(
              imageName: 'edit',
              height: 15.h,
              width: 15.h,
              color: AppColors.white,
            ),
          ),
        )
      ],
    );
  }
}
