import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../value/colors.dart';
import 'app_style_text.dart';
import 'custom_image.dart';

class CardTemplateTransparent extends StatelessWidget {
  final String title;
  final Color colorFont;
  final TextEditingController controller;
  final IconData? suffix;
  final String? prefix;
  final bool visible ;

  const CardTemplateTransparent(
      {Key? key,
      required this.title,
      required this.controller,
      this.suffix,
      this.visible = true,
      this.colorFont =AppColors.grey,
      this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53.h,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        elevation: 0,
        // elevation: 5.r,
        child: TextField(
          controller: controller,
          cursorColor: AppColors.appColor,
          decoration: InputDecoration(
            suffixIcon: Icon(
              suffix,
              color: AppColors.greyCC,
              size: 18.r,
            ),
            prefixIconConstraints: BoxConstraints.tight(Size(40.w, 16.h)),
            prefixIcon: CustomSvgImage(
              imageName: prefix,
              color: visible ? AppColors.grey: AppColors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grey,
                ),
                borderRadius: BorderRadius.circular(8.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grey,
                ),
                borderRadius: BorderRadius.circular(8.r)),
            labelStyle: const TextStyle(color: Colors.white),
            fillColor: Colors.white,
            label: AppTextStyle(
              name: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: colorFont,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
            // side: BorderSide(
            //   color: AppColors.grey,
            //
            // ),
            borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }
}
