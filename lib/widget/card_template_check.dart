import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../value/colors.dart';
import 'app_style_text.dart';

class CardTemplateCheck extends StatelessWidget {
  String image;

  String title;
  double heigth;
  bool click;

  void Function() onPressed;

  CardTemplateCheck({
    Key? key,
    this.heigth = 10,
    required this.click,
    required this.onPressed,
    required this.title,
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
          // color: click ? AppColors.appColor.withOpacity(.2) : AppColors.white,
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: CheckboxListTile(
                      // checkColor:AppColors.appColor  ,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                            // side: BorderSide(
                            //   color: AppColors.appColor
                            // ),
                      ),
                      contentPadding: EdgeInsets.all(0),
                      activeColor: AppColors.appColor,
                      title: AppTextStyle(
                        name: title,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        isMarai: false,
                        fontSize: 11.sp,
                      ),
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Spacer(),
                AppTextStyle(
                  name: '2.00 ليرة',
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  isMarai: false,
                  fontSize: 10.sp,
                )
              ],
            ),
          ),
          // shape: RoundedRectangleBorder(
          //     side: BorderSide(
          //       color: click ? AppColors.appColor : AppColors.grey,
          //     ),
          //     borderRadius: BorderRadius.circular(8.r)),
        ),
      ),
    );
  }
}
