import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_app/widget/row_icon.dart';
import 'package:driver_app/widget/row_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'component.dart';

class ContainerGridFavorite extends StatelessWidget {
  //                    'https://www.tailorbrands.com/wp-content/uploads/2020/07/mcdonalds-logo.jpg',

  String image;
  String mainTitle;
  String time;
  String rate;
  String space;
  String price;
  bool visible;
  bool isFav;
  void Function() onPressed;
  void Function() onPressed2;

  ContainerGridFavorite(
      {required this.price,
      required this.image,
      required this.mainTitle,
      required this.visible,
      this.isFav = true,
      required this.time,
      required this.onPressed,
      required this.onPressed2,
      required this.rate,
      required this.space});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed2,
      child: AbsorbPointer(
        child: Container(
          padding: EdgeInsets.zero,
          height: 160.h,
          decoration: BoxDecoration(
              color: AppColors.greyF8,
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            children: [
              Container(
                height: 122.h,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        // buildContext: context,
                        // height: 72.h,
                        // width: 72.w,
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
                    Visibility(
                      visible: isFav,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 9.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 40.h,
                                  width: 35.w,
                                  child: Card(
                                    color: AppColors.appColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Column(
                                      children: [
                                        AppTextStyle(
                                          textAlign: TextAlign.center,
                                          name: price,
                                          fontSize: 10.sp,
                                          isMarai: false,

                                          height: 1,

                                          color: AppColors.white,
                                          // fontWeight: FontWeight.w400,
                                        ),
                                        AppTextStyle(
                                          textAlign: TextAlign.center,
                                          name: 'ليرة',
                                          height: 1,
                                          isMarai: false,
                                          fontSize: 7.sp,
                                          color: AppColors.white,
                                          // fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: onPressed,
                              child: Container(
                                alignment: Alignment.center,
                                // padding: EdgeInsets.all(5.r),
                                height: 15.h,
                                width: 15.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white),
                                child: Icon(
                                  visible
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: visible
                                      ? AppColors.red
                                      : AppColors.black.withOpacity(0.4),
                                  size: 10.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle(
                    name: mainTitle,
                    fontSize: 9.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    isMarai: false,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RowIcon(
                          title: rate,
                          iconData: Icons.star_rate_rounded,
                          color: AppColors.appColor),
                      RowSvg(
                        title: '${time} دقيقة',
                        image: 'speed',
                      ),
                      // RowIcon(
                      //     title: '${time} دقيقة',
                      //     iconData: Icons.access_time_filled_rounded,
                      //     color: AppColors.black),
                      RowSvg(
                        title: 'يبعد ${space} كلم',
                        image: 'maps',
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
