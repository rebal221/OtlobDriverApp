import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'custom_image.dart';

@immutable
class AppButtonIconCheck extends StatefulWidget {
  final String title;
  final Color? color;
  final Widget icon;
  final double height;
  final double width;

  final void Function() onPressed;

  const AppButtonIconCheck(
      {Key? key,
      this.color = AppColors.appColor,
      this.height =  26,
      this.width = 13,
      required this.icon,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  State<AppButtonIconCheck> createState() => _AppButtonIconCheckState();
}

class _AppButtonIconCheckState extends State<AppButtonIconCheck> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: widget.onPressed,
      label:  AppTextStyle(
        textAlign: TextAlign.center,
        name: widget.title,
        fontSize:  6.sp,
        color: Colors.white,
      ),
      style: ElevatedButton.styleFrom(
          // padding: EdgeInsetsDirectional.only(start: 10.w),
          minimumSize: Size(double.infinity, 36.h),
          primary: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          )), icon:widget.icon,
    );
  }
}
