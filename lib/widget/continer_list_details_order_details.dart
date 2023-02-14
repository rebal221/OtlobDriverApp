import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_app/widget/app_button.dart';
import 'package:driver_app/widget/row_all.dart';
import 'package:driver_app/widget/row_icon.dart';
import 'package:driver_app/widget/row_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../value/colors.dart';
import 'app_style_text.dart';
import 'button_column.dart';
import 'cash_network.dart';
import 'component.dart';

class ContainerOrderDetails extends StatelessWidget {
  // 'https://cdn.alweb.com/thumbs/daleelalmata3em/article/fit710x532/%D9%85%D8%B7%D8%A7%D8%B9%D9%85-%D8%B4%D8%A7%D9%88%D8%B1%D9%85%D8%A7-%D9%81%D9%8A-%D8%B9%D8%A8%D8%AF%D9%88%D9%86.jpg',
  // 'https://cdn.mos.cms.futurecdn.net/6bxva8DmZvNj8kaVrQZZMP-970-80.jpg.webp',

  final bool visible;
  String mainImage;
  String secondImage;

  String mainTitle;
  String space;
  String time;
  String rate;
  String address;
  String mainGreen;
  String subGreen;
  String mainYellow;
  String subYellow;
  String map;
  String price;
  String name;
  String phone;
  String driverid;
  final double driverlat;
  final double driverlong;
  final double clienrlat;
  final double clienrlong;
  void Function() onPressed;
  void Function() onPressedAccept;
  void Function() onPressedAcceptDone;
  void Function() onPressedCancel;
  ContainerOrderDetails({
    required this.visible,
    required this.mainImage,
    required this.address,
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
    required this.name,
    required this.phone,
    required this.onPressed,
    required this.onPressedAccept,
    required this.onPressedCancel,
    required this.onPressedAcceptDone,
    required this.driverid,
    required this.driverlat,
    required this.driverlong,
    required this.clienrlat,
    required this.clienrlong,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        // height: 250.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Row(
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
                    RowSvg(
                        title: '${time} دقيقة',
                        image: 'speed',
                        color: AppColors.white),
                    SizedBox(
                      height: 7.h,
                    ),
                    RowSvg(
                        title: 'يبعد ${space} م',
                        image: 'maps',
                        color: AppColors.white),
                    SizedBox(
                      height: 7.h,
                    ),
                    RowIcon(
                        title: '${rate}',
                        iconData: Icons.access_time_outlined,
                        color: AppColors.white),
                  ],
                ),
              ],
            ),
            Divider(
              color: AppColors.greyDivider,
              thickness: 1.r,
            ),
            SizedBox(
              height: 10.h,
            ),
            AppTextStyle(
              name: 'تفاصيل الطلبية',
              fontSize: 10.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
              isMarai: false,
            ),
            SizedBox(
              height: 10.h,
            ),
            RowAll(mainTitle: 'العنوان', subTitle: address, onPressed: () {}),
            SizedBox(
              height: 10.h,
            ),
            RowAll(
                mainTitle: 'قيمة الطلب',
                subTitle: '${price} شيكل',
                onPressed: () {}),
            SizedBox(
              height: 10.h,
            ),
            RowAll(
                mainTitle: 'اسم العميل :',
                subTitle: '${name}',
                onPressed: () {}),
            SizedBox(
              height: 10.h,
            ),
            RowAll(
                mainTitle: 'رقم العميل :',
                subTitle: '${phone}',
                onPressed: () {}),
            Divider(
              color: AppColors.greyDivider,
              thickness: 1.r,
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 36.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  driverid == ''
                      ? Expanded(
                          child: AppButton(
                            title: 'رفض الطلب',
                            onPressed: onPressedCancel,
                            height: 36.h,
                            fontSize: 10.sp,
                            round: 6.r,
                            color: AppColors.appColor,
                          ),
                        )
                      : Text(''),
                  SizedBox(
                    width: driverid == '' ? 7.w : 0,
                  ),
                  driverid == ''
                      ? Expanded(
                          flex: 1,
                          child: AppButton(
                            title: 'قبول الطلب',
                            onPressed: onPressedAccept,
                            height: 36.h,
                            round: 6.r,
                            fontSize: 10.sp,
                            color: AppColors.greyA5,
                          ))
                      : (driverid != 'driverid'
                          ? Expanded(
                              flex: 1,
                              child: AppButton(
                                title: 'تسليم الطلب',
                                onPressed: onPressedAcceptDone,
                                height: 36.h,
                                round: 6.r,
                                fontSize: 10.sp,
                                color: AppColors.greyA5,
                              ))
                          : Expanded(
                              flex: 1,
                              child: AppButton(
                                title: 'تم تسليم الطلب',
                                onPressed: () {
                                  Get.back();
                                },
                                height: 36.h,
                                round: 6.r,
                                fontSize: 10.sp,
                                color: AppColors.greyA5,
                              ))),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.appColor),
              child: OrderPath(
                clienrlat: clienrlat,
                clienrlong: clienrlong,
                driverlat: driverlat,
                driverlong: driverlong,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderPath extends StatefulWidget {
  const OrderPath(
      {super.key,
      required this.driverlat,
      required this.driverlong,
      required this.clienrlat,
      required this.clienrlong});
  final double driverlat;
  final double driverlong;
  final double clienrlat;
  final double clienrlong;

  @override
  State<OrderPath> createState() => _OrderPathState();
}

// on below line we are initializing our controller for google maps.
Completer<GoogleMapController> _controller = Completer();

// on below line we are specifying our camera position

class _OrderPathState extends State<OrderPath> {
  @override
  Widget build(BuildContext context) {
    CameraPosition _kGoogle = CameraPosition(
      target: LatLng(widget.clienrlat, widget.clienrlong),
      zoom: 14.4746,
    );

// on below line we have created list of markers
    List<Marker> _marker = [
      // List of Markers Added on Google Map
      Marker(
          markerId: MarkerId('1'),
          position: LatLng(widget.clienrlat, widget.clienrlong),
          infoWindow: InfoWindow(
            title: 'My Position',
          )),

      Marker(
          markerId: MarkerId('2'),
          position: LatLng(widget.driverlat, widget.driverlong),
          infoWindow: InfoWindow(
            title: 'Location 1',
          )),
    ];
    return GoogleMap(
      // on below line setting camera position
      initialCameraPosition: _kGoogle,
      // on below line specifying map type.
      mapType: MapType.normal,
      // on below line setting user location enabled.
      myLocationEnabled: true,
      // on below line setting compass enabled.
      compassEnabled: true,
      markers: Set<Marker>.of(_marker),
      // on beloe line specifying controller on map complete.
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
