import 'package:driver_app/widget/app_style_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

Widget notificationIconWidget() {
  var player = AudioPlayer(); // Create a player

  player.setUrl(
      'https://firebasestorage.googleapis.com/v0/b/otlobdriverapp-dd897.appspot.com/o/notification.mp3?alt=media&token=6401dea9-f7ed-42ac-b5bb-985a6efb3aa2');

  return SizedBox(
    width: 40,
    height: 40,
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('orders').snapshots(),
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
          print(snapshot.data!.docs[0].data());
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
            print(onstep[i]['orderStatus']);
            if (onstep[i]['orderStatus'] == 'Inrestaurant') {
              counter += 1;
              orderCount += 1;
              player.play();
              id = orderKey[i].toString();
            }
          }
          orderCount > 0
              ? items += ['يوجد لديك ${orderCount} من الطلبات الجديدة']
              : [];
          return DropdownButtonHideUnderline(
            child: DropdownButton2(
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Row(
                          children: [
                            const Icon(Icons.notification_add_outlined,
                                size: 13, color: Colors.black),
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
                                      ? Color.fromARGB(5, 195, 44, 54)
                                      : Color(0xffc32c37),
                                  border: Border.all(
                                      color: Colors.white, width: 1.w)),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: AppTextStyle(
                                    name: counter == 0 ? '' : '$counter',
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
  );
}
