import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../value/colors.dart';
import 'app_style_text.dart';
import 'custom_image.dart';

class CardTemplateRadio extends StatelessWidget {
  String image;

  Widget widget;
  double heigth;
  bool click;

  void Function() onPressed;

  CardTemplateRadio({
    Key? key,
    this.heigth = 10,
   required this.click ,
    required this.onPressed,
    required this.widget,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 53.h,
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: click ? AppColors.appColor.withOpacity(.2) : AppColors.white,
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Expanded(
                    child: RadioListTile(
                  activeColor: AppColors.appColor,
                  title: widget,
                  value: 1,
                  groupValue: 1,
                  onChanged: (value) {},
                )),
                CustomSvgImage(
                  imageName: image,
                  height: heigth,
                  width: 26.w,
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: click ? AppColors.appColor : AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(8.r)),
        ),
      ),
    );
  }
}
