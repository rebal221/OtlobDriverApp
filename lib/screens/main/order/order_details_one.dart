import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/value/constant.dart';
import 'package:driver_app/widget/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:otlob/screens/sing_in.dart';
// import 'package:otlob/value/colors.dart';
// import 'package:otlob/widget/app_style_text.dart';
// import 'package:otlob/widget/row_edit_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:latlong2/latlong.dart' as lat;

import '../../../value/colors.dart';
import '../../../widget/app_style_text.dart';
import '../../../widget/card_template_black.dart';
import '../../../widget/component.dart';
import '../../../widget/continer_list_details.dart';
import '../../../widget/continer_list_details_done.dart';
import '../../../widget/continer_list_details_order_details.dart';
import '../../../widget/custom_image.dart';
import '../../Auth/sing_in.dart';
import 'order_details_accept_map.dart';
import 'order_details_multi.dart';

// import '../../widget/app_button.dart';
// import '../../widget/card_template.dart';
// import '../../widget/card_template_black.dart';
// import '../../widget/card_template_not.dart';
// import '../../widget/card_template_phone.dart';
// import '../../widget/custom_image.dart';
// import '../Auth/sing_in.dart';

class OrderDetailsOne extends StatefulWidget {
  const OrderDetailsOne(
      {Key? key,
      required this.pos,
      required this.ClientID,
      required this.OrderID,
      required this.resID,
      required this.destince,
      required this.driverlat,
      required this.driverlong,
      required this.clienrlat,
      required this.clienrlong})
      : super(key: key);
  final GeoPoint pos;
  final String ClientID;
  final String OrderID;
  final double driverlat;
  final double driverlong;
  final double clienrlat;
  final double clienrlong;
  final String resID;
  final String destince;
  @override
  State<OrderDetailsOne> createState() => _OrderDetailsOneState();
}

class _OrderDetailsOneState extends State<OrderDetailsOne> {
  late final TapGestureRecognizer _recognizer = TapGestureRecognizer()
    ..onTap = () => onTapRecognizer();
  bool isSwitched = true;

  late StreamController<LocationMarkerPosition> positionStream;
  late StreamSubscription<LocationMarkerPosition> streamSubscription;

  void onTapRecognizer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  LocationData? currentLocation;
  final Completer<GoogleMapController> _controller = Completer();
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  LatLng latLng = LatLng(31.524574924915523, 34.448129281505175);
  final defaultPinTheme = PinTheme(
    width: 51.w,
    height: 51.h,
    textStyle: const TextStyle(
        fontSize: 20, color: AppColors.greyF, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: AppColors.greyF,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: AppColors.greyF,
      ),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    positionStream = StreamController();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    super.initState();
  }

  @override
  void dispose() {
    positionStream.close();

    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: AppColors.appColor
    // ));
    return GlobalLoaderOverlay(
      textDirection: TextDirection.rtl,
      overlayColor: Colors.black,
      child: Scaffold(
        backgroundColor: AppColors.greyA5,
        appBar: AppBar(
          leadingWidth: 200.w,
          toolbarHeight: 50.h,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: TextButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 25.r,
            ),
            label: AppTextStyle(
              name: 'رجوع',
              fontSize: 10.sp,
            ),
          ),
          // leading: MenuWidget(),

          backgroundColor: AppColors.appColor,
          title: Text(''.tr),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('restaurant')
              .where('uid', isEqualTo: widget.resID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map data = snapshot.data!.docs[0].data() as Map;
              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppTextStyle(
                        name: 'توصيل طلب واحد',
                        fontSize: 12.sp,
                      ),
                      Spacer(),
                      SizedBox(
                        width: 180.w,
                        child: AppButton(
                          fontSize: 8.sp,
                          title: '${widget.OrderID}',
                          onPressed: () {},
                          color: AppColors.appColor,
                          height: 25.h,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 500.h,
                            decoration: BoxDecoration(
                              color: AppColors.greyF6,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('orders')
                                  .snapshots(),
                              builder: (context, a) {
                                if (a.hasData) {
                                  List order = [];
                                  List k = [];
                                  for (var i = 0;
                                      i < a.data!.docs.length;
                                      i++) {
                                    Map e = a.data!.docs[i].data() as Map;
                                    e.forEach((key, value) {
                                      if (key == widget.OrderID) {
                                        order += [value];
                                        k += [key];
                                      }
                                    });
                                  }
                                  String driverid = order[0]['DiverID'] == null
                                      ? ''
                                      : order[0]['DiverID'];
                                  return ContainerOrderDetails(
                                    driverid: driverid,
                                    clienrlat: widget.clienrlat,
                                    onPressedAcceptDone: () {
                                      FirebaseFirestore.instance
                                          .collection('orders')
                                          .doc(order[0]['clientID'])
                                          .set({
                                        k[index]: {
                                          'orderStatus': 'IsDone',
                                        }
                                      }, SetOptions(merge: true)).then((value) {
                                        FirebaseFirestore.instance
                                            .collection('drivers')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .get()
                                            .then((value) {
                                          Map driver = value.data() as Map;
                                          FirebaseFirestore.instance
                                              .collection('drivers')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .set({
                                            'OrderCount':
                                                driver['OrderCount'] + 1,
                                            'TotalPay': driver['OrderCount'] +
                                                order[0]['totalOrder'],
                                          }, SetOptions(merge: true));
                                        });
                                        driverid = 'done';
                                        getSheetSucsses('تم تسليم الطلب');
                                      });
                                    },
                                    clienrlong: widget.clienrlong,
                                    driverlat: widget.driverlat,
                                    driverlong: widget.driverlong,
                                    visible: true,
                                    name: '${order[0]['clientName']}',
                                    phone: '${order[0]['clientPhone']}',
                                    address: '${order[0]['postionName']}',
                                    mainImage: data['images'][0],
                                    secondImage: data['images'][2],
                                    mainTitle: data['name'],
                                    time: 'يجب توصيله خلال 25 - 30 ',
                                    space: widget.destince,
                                    rate: '22-05-2022   10:45 مساء',
                                    mainGreen: 'التوصيل مجانا',
                                    subGreen: 'لفترة محدودة',
                                    mainYellow: '45',
                                    subYellow: 'خصم على كل الطلبات',
                                    map: 'أبو مازن السوري',
                                    price: '${order[0]['totalOrder']}',
                                    onPressed: () {},
                                    onPressedAccept: () async {
                                      context.loaderOverlay
                                          .show(widget: ReconnectingOverlay());
                                      FirebaseFirestore.instance
                                          .collection('drivers')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .get()
                                          .then((value) {
                                        Map e = value.data() as Map;
                                        if (e['userRate'] == 'مستخدم مقبول') {
                                          FirebaseFirestore.instance
                                              .collection('orders')
                                              .doc(widget.ClientID)
                                              .set({
                                            widget.OrderID: {
                                              'orderStatus': 'DriverAccept',
                                              'DiverID': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                            }
                                          }, SetOptions(merge: true));
                                        } else if (e['userRate'] ==
                                            'مستخدم مرفوض') {
                                          getSheetError(
                                              'تم رفض الحساب لا يمكن استلام الطلب');
                                        } else if (e['userRate'] ==
                                            'مستخدم جديد') {
                                          getSheetError(
                                              'لا يمكن استلام الطلب قبل الموافقة على الحساب');
                                        }
                                      });

                                      await Future.delayed(Duration(seconds: 3),
                                          () {
                                        context.loaderOverlay.hide();
                                      });
                                    },
                                    onPressedCancel: () {
                                      Get.back();
                                    },
                                  );
                                } else {
                                  return Text("No data");
                                }
                              },
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 16.h,
                        );
                      },
                      itemCount: 1),
                ],
              );
            } else {
              return Text("");
            }
          },
        ),
      ),
    );
  }
}

Widget shimmerCarDesA(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: AppColors.appColor,
    highlightColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(0)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    ),
  );
}

class ReconnectingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 150.h,
                child: Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_usmfx6bp.json')),
            AppTextStyle(
              textAlign: TextAlign.center,
              fontSize: 15.sp,
              height: 2,
              name: '''برجاء الانتظار
جاري تأكيد الطلب''',
              color: Colors.white,
            ),
            // Text(
            //
            //   ' ... جاري التحميل',
            // ),
          ],
        ),
      );
}
