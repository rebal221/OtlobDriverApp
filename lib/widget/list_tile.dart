import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../value/colors.dart';
import 'app_style_text.dart';

class ListTileClass extends StatelessWidget {
  late String title;
  late String subTitle;
  late String trailing;
  late bool isLast;
  late bool isFirst;
  late bool disable = false;

  ListTileClass(
      {required this.title,
      required this.subTitle,
      required this.trailing,
      this.disable = false,
      this.isFirst = false,
      this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disable ? 0.3 : 1,
      child: TimelineTile(
        hasIndicator: true,
        alignment: TimelineAlign.manual,
        lineXY: 0.1,
        isLast: isLast,
        isFirst: isFirst,
        indicatorStyle: IndicatorStyle(
          height: 32.h,
          indicator: Container(
            decoration: BoxDecoration(
              color: !disable ? AppColors.appColor : AppColors.grey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 20.r,
            ),
          ),
          width: 50.r,

          color: !disable ? AppColors.appColor : AppColors.grey,
          padding: EdgeInsets.all(6),
        ),
        endChild: ListTile(
          subtitle: AppTextStyle(
            name: subTitle,
            fontSize: 8.sp,
            color: AppColors.grey,
          ),
          title: AppTextStyle(
            name: title,
            fontSize: 12.sp,
            color: AppColors.black,

          ),

        ),
        beforeLineStyle: LineStyle(
          color: !disable ? AppColors.appColor : AppColors.grey,
        ),
      ),
    );
  }
}
