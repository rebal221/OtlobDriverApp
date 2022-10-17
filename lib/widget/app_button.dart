import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../value/colors.dart';
import 'app_style_text.dart';

@immutable
class AppButton extends StatefulWidget {
  final String title;
  final double height;
  final double fontSize;
  final double round;
  final Color? color;
  final Color colorFont;
  final void Function() onPressed;

  const AppButton(
      {Key? key,
      this.color = AppColors.appColor,
      this.colorFont = AppColors.white,
      this.height = 50,
      this.fontSize = 14,
      this.round = 11,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: AppTextStyle(
        name: widget.title,
        fontSize: widget.fontSize.sp,
        color: widget.colorFont,
      ),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, widget.height.h),
          primary: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.round.r),
          )),
    );
  }
}
