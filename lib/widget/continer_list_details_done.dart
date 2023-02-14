import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_app/widget/app_button.dart';
import 'package:driver_app/widget/row_icon.dart';
import 'package:driver_app/widget/row_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'button_column.dart';
import 'component.dart';

class ContainerListDetailsDone extends StatelessWidget {
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
  void Function() onPressed;
  void Function() onpressclient;

  ContainerListDetailsDone({
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
    required this.onpressclient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      height: 70.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
              AppTextStyle(
                name: mainTitle,
                fontSize: 9.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                isMarai: false,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  RowSvg(title: time, image: 'order', color: AppColors.white),
                  RowSvg(title: rate, image: 'confirm', color: AppColors.white),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  RowSvg(
                      title: mainImage, image: 'menu', color: AppColors.white),
                  SizedBox(
                    width: 5.w,
                  ),
                  RowSvg(title: space, image: 'offers', color: AppColors.white),
                  SizedBox(
                    width: 5.w,
                  ),
                  RowSvg(
                      title: 'تم التوصيل',
                      image: 'speed',
                      color: AppColors.white),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ContainerListDetailsDriver extends StatelessWidget {
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
  void Function() onPressed;
  void Function() onpressclient;
  void Function() onpressclientdet;

  ContainerListDetailsDriver({
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
    required this.onpressclient,
    required this.onpressclientdet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      height: 100.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppTextStyle(
                name: mainTitle,
                fontSize: 9.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                isMarai: false,
              ),
              SizedBox(
                height: 5.h,
              ),
              RowSvg(title: time, image: 'confirm', color: AppColors.white),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  RowSvg(
                      title: mainImage,
                      image: 'offers',
                      color: AppColors.white),
                  SizedBox(
                    width: 5.w,
                  ),
                  RowSvg(
                      title: 'جاري التوصيل',
                      image: 'speed',
                      color: AppColors.white),
                ],
              )
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 35,
                width: 100.w,
                child: AppButton(
                  title: 'تسليم',
                  onPressed: onpressclient,
                  fontSize: 10.sp,
                  color: AppColors.appColor,
                  height: 36.h,
                  round: 6.r,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 35,
                width: 100.w,
                child: AppButton(
                  title: 'تفاصيل',
                  onPressed: onpressclientdet,
                  fontSize: 10.sp,
                  color: Colors.amber,
                  height: 36.h,
                  round: 6.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
