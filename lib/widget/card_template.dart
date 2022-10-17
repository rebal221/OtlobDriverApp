import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'custom_image.dart';

class CardTemplate extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData? suffix;
  final String? prefix;

  const CardTemplate(
      {Key? key,
      required this.title,
      required this.controller,
      this.suffix,
      this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: Card(

        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        elevation: 5.r,
        child: TextField(

          controller: controller,
          cursorColor: AppColors.appColor,
          decoration: InputDecoration(
            suffix: Icon(
              suffix,
              color: AppColors.greyC,
            ),
            prefixIconConstraints: BoxConstraints.tight(Size(40.w, 16.h)),
            prefixIcon: CustomSvgImage(
              imageName: prefix,
              color: AppColors.greyC,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelStyle: const TextStyle(color: Colors.white),
            fillColor: Colors.white,
            label: AppTextStyle(
              name: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.greyC,
            ),
          ),

        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }
}
