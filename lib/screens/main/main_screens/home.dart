import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/screens/main/order/order_details_multi.dart';
import 'package:driver_app/screens/main/order/order_details_one.dart';
import 'package:driver_app/value/constant.dart';
import 'package:driver_app/widget/app_button.dart';
import 'package:driver_app/widget/notifcation_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:location/location.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:otlob/screens/sing_in.dart';
// import 'package:otlob/value/colors.dart';
// import 'package:otlob/widget/app_style_text.dart';
// import 'package:otlob/widget/row_edit_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timer_count_down/timer_count_down.dart';
// import 'package:latlong2/latlong.dart';

import '../../../value/colors.dart';
import '../../../widget/app_style_text.dart';
import '../../../widget/card_template_black.dart';
import '../../../widget/component.dart';
import '../../../widget/continer_list_details.dart';
import '../../../widget/continer_list_details_done.dart';
import '../../../widget/custom_image.dart';
import '../../Auth/sing_in.dart';

// import '../../widget/app_button.dart';
// import '../../widget/card_template.dart';
// import '../../widget/card_template_black.dart';
// import '../../widget/card_template_not.dart';
// import '../../widget/card_template_phone.dart';
// import '../../widget/custom_image.dart';
// import '../Auth/sing_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TapGestureRecognizer _recognizer = TapGestureRecognizer()
    ..onTap = () => onTapRecognizer();
  bool isSwitched = true;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);
  GoogleMapController? mapController;
  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  // late StreamController<LocationMarkerPosition> positionStream;
  // late StreamSubscription<LocationMarkerPosition> streamSubscription;

  void onTapRecognizer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  static const distanceFilters = [0, 5, 10, 30, 50];
  int _selectedIndex = 0;
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
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
  LocationData? currentLocation;
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

  @override
  void initState() {
    // TODO: implement initState

    // positionStream = StreamController();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    getCurrentLocation();
    super.initState();
    user = _auth.currentUser;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification(String title, String body) {
    flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  void dispose() {
    // positionStream.close();

    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    super.dispose();
  }

  final _auth = FirebaseAuth.instance;
  User? user;
  GeoPoint? pos;
  LatLng latLng = LatLng(0.0, 0.0);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: AppColors.appColor
    // ));
    return Scaffold(
      backgroundColor: AppColors.greyA5,
      appBar: AppBar(
        toolbarHeight: 80.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // leading: MenuWidget(),
        leading: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('drivers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map driver = (snapshot.data!.data() == null)
                  ? {}
                  : snapshot.data!.data() as Map;

              return Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 45.h,
                      width: 45.w,
                      // padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle,
                          color: Colors.white),
                      child: SizedBox(
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: CachedNetworkImage(
                            imageUrl:
                                driver['Img'] == null ? '' : driver['Img'],
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
                            placeholder: (context, url) =>
                                shimmerCarDes(context),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppTextStyle(
                          name: 'مرحباً',
                          fontWeight: FontWeight.w900,
                          fontSize: 10.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Text("");
            }
          },
        ),
        leadingWidth: 300,
        titleSpacing: 0,
        centerTitle: false,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String? selectedValue;
                      List<String> items = [];
                      int orderCount = 0;
                      List onstep = [];
                      int counter = 0;
                      Map orders = {};
                      String id = '';
                      List orderKey = [];
                      List orderValue = [];
                      for (var i = 0; i < snapshot.data!.docs.length; i++) {
                        Map e = snapshot.data!.docs[i].data() == null
                            ? {}
                            : snapshot.data!.docs[i].data() as Map;
                        e.forEach((key, value) {
                          onstep += [value];
                          orderKey += [key];
                        });
                      }

                      for (var i = 0; i < onstep.length; i++) {
                        if (onstep[i]['orderStatus'] == 'Inrestaurant') {
                          counter += 1;
                          orderCount += 1;
                          id = orderKey[i].toString();
                          showNotification(
                              'طلب من مطعم ${onstep[i]['restaurantName']}',
                              'يجب توصيله خلال فترة اقصاها 30 دقيقة');
                        }
                      }

                      orderCount > 0
                          ? items += [
                              'يوجد لديك ${orderCount} من الطلبات الجديدة'
                            ]
                          : [];
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Row(
                                      children: [
                                        const Icon(
                                            Icons.notification_add_outlined,
                                            size: 13,
                                            color: Colors.black),
                                        const SizedBox(width: 5),
                                        Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          isExpanded: true,
                          offset: Offset(10, 0),
                          isDense: true,
                          customButton: Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_none_outlined,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 25.r,
                                ),
                                counter == 0
                                    ? Text('')
                                    : Container(
                                        width: 30.w,
                                        height: 30.h,
                                        alignment: Alignment.topRight,
                                        margin: EdgeInsets.only(bottom: 10.h),
                                        child: Container(
                                          width: 15.h,
                                          height: 15.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: counter == 0
                                                  ? Color.fromARGB(
                                                      5, 195, 44, 54)
                                                  : Color(0xffc32c37),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.w)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Center(
                                              child: AppTextStyle(
                                                name: counter == 0
                                                    ? ''
                                                    : '$counter',
                                                fontSize: 8.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          dropdownOverButton: false,
                          dropdownWidth: 250,
                          focusColor: Colors.white,
                          itemHeight: 40,
                        ),
                      );
                    } else {
                      return const Text("");
                    }
                  },
                ),
              )
            ],
          ),
          SizedBox(
            width: 20.w,
          ),
        ],
        backgroundColor: AppColors.appColor,
        title: Text(''.tr),
      ),
      body: ListView(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 0.h),
        children: [
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            children: [
              SizedBox(
                height: 10.h,
              ),
              AppTextStyle(
                name: 'الطلبات الحالية',
                fontSize: 12.sp,
              ),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('orders').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List ordersV = [];
                    List ordersK = [];
                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      Map newOrder = snapshot.data!.docs[i].data() as Map;
                      newOrder.forEach((key, value) {
                        if (value['orderStatus'] == 'Inrestaurant' ||
                            (value['orderStatus'] == 'Todriver' &&
                                value['driverID'] ==
                                    FirebaseAuth.instance.currentUser!.uid)) {
                          value['orderStatus'] == 'Todriver'
                              ? showNotification(
                                  'تم اختيارك من مطعم ${value['restaurantName']} لتوصيل طلب',
                                  'يجب توصيله خلال فترة اقصاها 30 دقيقة')
                              : null;
                          ordersV += [value];
                          ordersK += [key];
                        }
                      });
                    }
                    return ordersV.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 95.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.greyF6,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('restaurant')
                                        .where('uid',
                                            isEqualTo: ordersV[index]
                                                ['restaurantID'][0])
                                        .get(),
                                    builder: (context, s) {
                                      if (s.connectionState ==
                                          ConnectionState.done) {
                                        Map rest =
                                            s.data!.docs[0].data() == null
                                                ? {}
                                                : s.data!.docs[0].data() as Map;
                                        pos = GeoPoint(
                                            double.parse(ordersV[index]
                                                ['postionCoordinates'][0]),
                                            double.parse(ordersV[index]
                                                ['postionCoordinates'][1]));
                                        var distanc =
                                            Geolocator.distanceBetween(
                                                currentLocation!.latitude!,
                                                currentLocation!.longitude!,
                                                pos!.latitude,
                                                pos!.longitude);
                                        Timestamp timestamp = ordersV[index]
                                                ['orderTimeLastUpdate']
                                            as Timestamp;
                                        DateTime dateTime = timestamp.toDate();
                                        return ContainerListDetails(
                                            onPressedtow: () {
                                              // FirebaseFirestore.instance
                                              //     .collection('orders')
                                              //     .doc(ordersV[index]
                                              //         ['ClientID'])
                                              //     .set({
                                              //   ordersK[index]: {
                                              //     'orderStatus': 'DriverAccept',
                                              //     'DiverID': FirebaseAuth
                                              //         .instance
                                              //         .currentUser!
                                              //         .uid,
                                              //   }
                                              // }, SetOptions(merge: true));
                                            },
                                            visible: true,
                                            mainImage: rest['images'][0],
                                            secondImage: rest['images'][1],
                                            mainTitle:
                                                '${ordersV[index]['restaurantName']}',
                                            time: 'يجب توصيله خلال 25 - 30 ',
                                            space: distanc.toStringAsFixed(1),
                                            rate: dateTime.toString(),
                                            mainGreen: 'التوصيل مجانا',
                                            subGreen: 'لفترة محدودة',
                                            mainYellow: '45',
                                            subYellow: 'خصم على كل الطلبات',
                                            map: 'أبو مازن السوري',
                                            price: '78',
                                            onPressed: () async {
                                              // if (index == 0) {

                                              Get.to(OrderDetailsOne(
                                                clienrlat: pos!.latitude,
                                                clienrlong: pos!.longitude,
                                                driverlat:
                                                    (currentLocation == null)
                                                        ? 0
                                                        : currentLocation!
                                                            .latitude!,
                                                driverlong:
                                                    (currentLocation == null)
                                                        ? 0
                                                        : currentLocation!
                                                            .longitude!,
                                                destince:
                                                    distanc.toStringAsFixed(1),
                                                resID: ordersV[index]
                                                    ['restaurantID'][0],
                                                ClientID: ordersV[index]
                                                    ['clientID'],
                                                OrderID: ordersK[index],
                                                pos: pos!,
                                              ));
                                              // } else {
                                              //   Get.to(OrderDetailsMulti());
                                              // }
                                            });
                                      } else {
                                        return Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.white38)),
                                          child: AppTextStyle(
                                            name: "لا يوجد طلبات جديدة",
                                            fontSize: 8.sp,
                                          ),
                                        );
                                      }
                                    },
                                  ));
                            },
                            separatorBuilder: (context, index) {
                              return Text('');
                            },
                            itemCount: ordersV.length)
                        : Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width - 100.w,
                            child: AppTextStyle(
                              name: "لا يوجد طلبات جديدة",
                              fontSize: 8.sp,
                            ),
                          );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 100.w,
                      child: AppTextStyle(
                        name: "لا يوجد طلبات جديدة",
                        fontSize: 8.sp,
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              AppTextStyle(
                name: 'طلبات جاري توصيلها',
                fontSize: 12.sp,
              ),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('orders').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List ov = [];
                    List ok = [];
                    Map e = {};
                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      Map newOrder = snapshot.data!.docs[i].data() as Map;
                      newOrder.forEach((key, value) {
                        if (value['orderStatus'] == 'DriverAccept' &&
                            value['DiverID'] ==
                                FirebaseAuth.instance.currentUser!.uid) {
                          ov += [value];
                          ok += [key];
                        }
                      });
                    }

                    return ov.isNotEmpty
                        ? StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('restaurant')
                                .where('uid',
                                    isEqualTo: ov[0]['restaurantID'][0])
                                .snapshots(),
                            builder: (context, snapshot) {
                              e = snapshot.data!.docs[0].data() as Map;
                              return ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    Timestamp t =
                                        ov[index]['orderTimeLastUpdate'];
                                    DateTime d = t.toDate();
                                    pos = GeoPoint(
                                        double.parse(
                                            ov[index]['postionCoordinates'][0]),
                                        double.parse(ov[index]
                                            ['postionCoordinates'][1]));
                                    var distanc = Geolocator.distanceBetween(
                                        currentLocation!.latitude!,
                                        currentLocation!.longitude!,
                                        pos!.latitude,
                                        pos!.longitude);
                                    return Container(
                                        height: 90.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.greyF6,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: ContainerListDetailsDriver(
                                            visible: true,
                                            onpressclientdet: () {
                                              Get.to(OrderDetailsOne(
                                                clienrlat: pos!.latitude,
                                                clienrlong: pos!.longitude,
                                                driverlat:
                                                    (currentLocation == null)
                                                        ? 0
                                                        : currentLocation!
                                                            .latitude!,
                                                driverlong:
                                                    (currentLocation == null)
                                                        ? 0
                                                        : currentLocation!
                                                            .longitude!,
                                                destince:
                                                    distanc.toStringAsFixed(1),
                                                resID: ov[index]['restaurantID']
                                                    [0],
                                                ClientID: ov[index]['clientID'],
                                                OrderID: ok[index],
                                                pos: pos!,
                                              ));
                                            },
                                            onpressclient: () {
                                              FirebaseFirestore.instance
                                                  .collection('orders')
                                                  .doc(ov[index]['clientID'])
                                                  .set({
                                                ok[index]: {
                                                  'orderStatus': 'IsDone',
                                                }
                                              }, SetOptions(merge: true)).then(
                                                      (value) {
                                                FirebaseFirestore.instance
                                                    .collection('drivers')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .get()
                                                    .then((value) {
                                                  Map driver =
                                                      value.data() as Map;
                                                  FirebaseFirestore.instance
                                                      .collection('drivers')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .set({
                                                    'OrderCount':
                                                        driver['OrderCount'] +
                                                            1,
                                                    'TotalPay':
                                                        driver['OrderCount'] +
                                                            ov[index]
                                                                ['totalOrder'],
                                                  }, SetOptions(merge: true));
                                                });
                                                getSheetSucsses(
                                                    'تم تسليم الطلب');
                                              });
                                            },
                                            mainImage:
                                                '${ov[index]['totalOrder']} شيكل',
                                            secondImage: e['images'][0],
                                            mainTitle: ov[index]
                                                ['restaurantName'],
                                            time: d.toString(),
                                            space: '5.2',
                                            rate: '22-05-2022   10:45 مساء',
                                            mainGreen: 'التوصيل مجانا',
                                            subGreen: 'لفترة محدودة',
                                            mainYellow: '45',
                                            subYellow: 'خصم على كل الطلبات',
                                            map: 'أبو مازن السوري',
                                            price: '78',
                                            onPressed: () {}));
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 16.h,
                                    );
                                  },
                                  itemCount: ov.length);
                            })
                        : Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width - 100.w,
                            child: AppTextStyle(
                              name: 'لا يوجد طلبات',
                              fontSize: 8.sp,
                            ),
                          );
                  } else {
                    return Text("");
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              AppTextStyle(
                name: 'الطلبات المكتملة',
                fontSize: 12.sp,
              ),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('orders').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List ov = [];
                    List ok = [];
                    Map e = {};
                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      Map newOrder = snapshot.data!.docs[i].data() as Map;
                      newOrder.forEach((key, value) {
                        if (value['orderStatus'] == 'IsDone' &&
                            value['DiverID'] ==
                                FirebaseAuth.instance.currentUser!.uid) {
                          ov += [value];
                          ok += [key];
                        }
                      });
                    }
                    return ov.isNotEmpty
                        ? StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('restaurant')
                                .where('uid',
                                    isEqualTo:
                                        (ov[0]['restaurantID'][0] == null)
                                            ? ''
                                            : ov[0]['restaurantID'][0])
                                .snapshots(),
                            builder: (context, snapshot) {
                              e = snapshot.data!.docs[0].data() as Map;
                              return ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.greyF6,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: ContainerListDetailsDone(
                                            visible: true,
                                            onpressclient: () {},
                                            mainImage: ok[index],
                                            secondImage: e['images'][0],
                                            mainTitle: ov[index]
                                                ['restaurantName'],
                                            time: ov[index]['postionName']
                                                .toString(),
                                            space: ov[index]['totalOrder']
                                                .toString(),
                                            rate: '22-05-2022   10:45 مساء',
                                            mainGreen: 'التوصيل مجانا',
                                            subGreen: 'لفترة محدودة',
                                            mainYellow: '45',
                                            subYellow: 'خصم على كل الطلبات',
                                            map: 'أبو مازن السوري',
                                            price: '78',
                                            onPressed: () {}));
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 16.h,
                                    );
                                  },
                                  itemCount: ov.length);
                            })
                        : Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width - 100.w,
                            child: AppTextStyle(
                              name: 'لا يوجد طلبات تم توصيلها بعد',
                              fontSize: 8.sp,
                            ),
                          );
                  } else {
                    return Text("");
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              AppTextStyle(
                name: 'موقعي الحالي',
                fontSize: 12.sp,
              ),
              SizedBox(
                height: 10.h,
              ),
              Mylocation(
                  currentLocation: currentLocation,
                  press: () {
                    setState(() {});
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

class Mylocation extends StatefulWidget {
  const Mylocation({
    Key? key,
    required this.currentLocation,
    required this.press,
  }) : super(key: key);

  final LocationData? currentLocation;
  final void Function() press;

  @override
  State<Mylocation> createState() => _MylocationState();
}

class _MylocationState extends State<Mylocation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 122.h,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: 122.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (widget.currentLocation != null) {
              return GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      (widget.currentLocation == null)
                          ? 0.0
                          : widget.currentLocation!.latitude!,
                      (widget.currentLocation == null)
                          ? 0.0
                          : widget.currentLocation!.longitude!),
                  zoom: 13.5,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: LatLng(widget.currentLocation!.latitude!,
                        widget.currentLocation!.longitude!),
                  ),
                },
                onMapCreated: (mapController) {},
              );
            } else {
              return Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 100.w,
                height: 90.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white38)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextStyle(
                      name: 'لا توجد بيانات',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 100.w,
                      height: 40.h,
                      child: AppButton(
                        title: 'تحديث',
                        onPressed: widget.press,
                        color: AppColors.appColor,
                      ),
                    ),
                  ],
                ),
              );
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
