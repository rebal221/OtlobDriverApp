import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_app/widget/app_button.dart';
import 'package:driver_app/widget/row_icon.dart';
import 'package:driver_app/widget/row_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'button_column.dart';
import 'component.dart';

class ContainerListDetails extends StatelessWidget {
  // 'https://cdn.alweb.com/thumbs/daleelalmata3em/article/fit710x532/%D9%85%D8%B7%D8%A7%D8%B9%D9%85-%D8%B4%D8%A7%D9%88%D8%B1%D9%85%D8%A7-%D9%81%D9%8A-%D8%B9%D8%A8%D8%AF%D9%88%D9%86.jpg',
  // 'https://cdn.mos.cms.futurecdn.net/6bxva8DmZvNj8kaVrQZZMP-970-80.jpg.webp',

  final bool visible;
  String mainImage;
  String secondImage;

  String mainTitle;
  String space;
  String time;
  String rate;
  String mainGreen;
  String subGreen;
  String mainYellow;
  String subYellow;
  String map;
  String price;
  void Function() onPressedtow;
  void Function() onPressed;

  ContainerListDetails({
    required this.visible,
    required this.mainImage,
    required this.secondImage,
    required this.mainTitle,
    required this.space,
    required this.time,
    required this.rate,
    required this.mainGreen,
    required this.subGreen,
    required this.mainYellow,
    required this.subYellow,
    required this.map,
    required this.price,
    required this.onPressed,
    required this.onPressedtow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AbsorbPointer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          height: 400.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 45.h,
                width: 45.w,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CachedNetworkImage(
                    imageUrl: secondImage,
                    // buildContext: context,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => shimmerCarDes(context),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 180,
                    child: AppTextStyle(
                      name: mainTitle,
                      fontSize: 9.sp,
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      isMarai: false,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RowSvg(
                      title: '${time} دقيقة',
                      image: 'speed',
                      color: AppColors.white),
                  SizedBox(
                    height: 5.h,
                  ),
                  RowSvg(
                      title: 'يبعد ${space} م',
                      image: 'maps',
                      color: AppColors.white),
                  SizedBox(
                    height: 5.h,
                  ),
                  RowIcon(
                      title: '${rate}',
                      iconData: Icons.access_time_outlined,
                      color: AppColors.white),
                ],
              ),
              Spacer(),
              SizedBox(
                width: 100.w,
                child: Column(
                  children: [
                    Expanded(
                      child: AppButton(
                        title: 'تلقي الطلب',
                        onPressed: onPressedtow,
                        fontSize: 8.sp,
                        color: AppColors.appColor2,
                        height: 30.h,
                        round: 6.r,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Expanded(
                      child: AppButton(
                        title: 'تفاصيل',
                        onPressed: () async {},
                        fontSize: 8.sp,
                        color: AppColors.appColor,
                        height: 30.h,
                        round: 6.r,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
