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

class MapDetailsCustomer extends StatelessWidget {
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

  MapDetailsCustomer({
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              OrderRow(
                secondImage: secondImage,
                mainTitle: mainTitle,
                isMap: true,
                time: time,
                space: space,
                onPressedAccept: onPressedAccept,
              ),

            ],
          ),
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
    required this.onPressedAccept,
  }) : super(key: key);

  final String secondImage;
  final String mainTitle;
  final String time;
  final String space;
  final bool isMap;
  final void Function() onPressedAccept;

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
        SizedBox(
          width: 108.w,
          child: AppButton(
            title: 'تأكيد استلام الطلبية',
            onPressed: onPressedAccept,
            fontSize: 8.sp,
            color: AppColors.appColor,
            height: 36.h,
            round: 6.r,
          ),
        ),
      ],
    );
  }
}
