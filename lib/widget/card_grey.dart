import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'custom_image.dart';

class CardGrey extends StatelessWidget {
  String image;

  double heigth;
  bool click;

  // void Function() onPressed;

  CardGrey({
    Key? key,
    this.heigth = 17,
   required this.click ,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 60.w,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: click ? AppColors.appColor.withOpacity(.2) : AppColors.white,
        elevation: 0,
        child: Center(
          child: CustomSvgImage(
            imageName: image,
            height: heigth,
            width: 26.w,
          ),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: click ? AppColors.appColor : AppColors.grey,
            ),
            borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }
}
