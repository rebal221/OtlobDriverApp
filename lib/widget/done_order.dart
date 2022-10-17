import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_app/widget/app_button.dart';
import 'package:driver_app/widget/app_button_icon.dart';
import 'package:driver_app/widget/cash_network.dart';
import 'package:driver_app/widget/row_all.dart';
import 'package:driver_app/widget/row_icon.dart';
import 'package:driver_app/widget/row_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_button_icon_check.dart';
import 'app_style_text.dart';
import 'button_column.dart';
import 'component.dart';

class DoneOrder extends StatelessWidget {
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
  void Function() onPressedAccept;
  void Function() onPressedCancel;
  void Function() onPressedMap;
  void Function() onPressedMapDetails;

  DoneOrder({
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
    required this.onPressedMap,
    required this.onPressedMapDetails,
    required this.onPressedAccept,
    required this.onPressedCancel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
        // height: 250.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            OrderRow(
              secondImage: secondImage,
              mainTitle: mainTitle,
              isMap: false,
              time: time,
              space: space,
              onPressedMap: onPressedMap,
            ),
            Divider(
              color: AppColors.greyDivider,
              thickness: 1.r,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle(
                    name: 'تفاصيل الطلبية',
                    fontSize: 10.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    isMarai: false,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      // SizedBox(width: 6.w,)
                      RowAll(
                          mainTitle: 'العنوان',
                          subTitle: 'الضفة الغربية - بجوار عصائر مكة',
                          onPressed: () {}),
                      Spacer(),
                      SizedBox(
                        width: 106.w,
                        child: AppButtonIconCheck(
                          title: 'تم التوصيل',

                          onPressed: () {





                          },
                          // fontSize: 6.sp,
                          color: AppColors.appColorA65,
                          height: 36.h,
                          icon: Icon(
                            Icons.check_circle,
                            color: AppColors.green48,
                            size: 10.r,
                          ),
                        ),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  RowAll(
                      mainTitle: 'قيمة الطلب',
                      subTitle: '140 ليرة',
                      onPressed: () {}),
                  Divider(
                    color: AppColors.greyDivider,
                    thickness: 1.r,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 36.h,
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'تم توصيل الطلب',
                      onPressed: onPressedCancel,
                      height: 36.h,
                      fontSize: 10.sp,
                      round: 6.r,
                      colorFont:
                          !visible ? AppColors.white : AppColors.appColorF7,
                      color:
                          !visible ? AppColors.appColor2 : AppColors.appColorF7,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderRow extends StatelessWidget {
  const OrderRow({
    Key? key,
    this.isMap = false,
    required this.secondImage,
    required this.mainTitle,
    required this.time,
    required this.space,
    required this.onPressedMap,
  }) : super(key: key);

  final String secondImage;
  final String mainTitle;
  final String time;
  final String space;
  final bool isMap;

  final void Function() onPressedMap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45.h,
          width: 45.w,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: CachNetwork(image: secondImage),
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
              fontSize: 11.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
              isMarai: false,
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                RowSvg(
                    title: '${time} دقيقة',
                    image: 'speed',
                    color: AppColors.white),
                RowSvg(
                    title: 'يبعد ${space} كلم',
                    image: 'maps',
                    color: AppColors.white),
              ],
            ),
          ],
        ),
        Spacer(),
        Visibility(
          visible: false,
          replacement: SizedBox(
            width: 106.w,
            child: AppButtonIconCheck(
              title: 'تم الاستلام من المطعم',

              onPressed: () {},
              // fontSize: 6.sp,
              color: AppColors.appColorA65,
              height: 36.h,
              icon: Icon(
                Icons.check_circle,
                color: AppColors.green48,
                size: 10.r,
              ),
            ),
          ),
          child: SizedBox(
            width: 106.w,
            child: AppButtonIconCheck(
              title: 'تم الاستلام من المطعم',

              onPressed: () {},
              // fontSize: 6.sp,
              color: AppColors.appColorA65,
              height: 36.h,
              icon: Icon(
                Icons.check_circle,
                color: AppColors.green48,
                size: 10.r,
              ),
            ),
          ),


        ),
      ],
    );
  }
}
