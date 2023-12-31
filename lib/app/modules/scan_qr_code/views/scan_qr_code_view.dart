import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/scan_qr_code_controller.dart';

class ScanQrCodeView extends GetView<ScanQrCodeController> {
  const ScanQrCodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            alignment: Alignment.center,
            height: 65.h,
            width: 85.w,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(
                  2.0,
                  2.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ], borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_rounded,
                  color: Colors.black,
                  size: 30.h,
                ),
                Text(
                  "Delivery Item",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                ),
                SizedBox(
                  height: 4.w,
                ),
                Container(
                  width: Get.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 14.sp)),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text('12 PCS',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 14.sp)),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 12.w,
                  endIndent: 12.w,
                ),
                Container(
                  width: Get.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total KM',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 14.sp)),
                      Text('2.4 KM',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 14.sp)),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 12.w,
                  endIndent: 12.w,
                ),
                Container(
                  width: Get.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 14.sp)),
                      Text('250 ETB',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 14.sp)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.w,
                ),
                finishandstartbutton(context)
              ],
            )),
      ),
    );
  }

  Container finishandstartbutton(BuildContext context) {
    return Container(
      height: 15.w,
      width: 60.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.blue,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 2.3.h),
        ),
        child: Text("Done",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: CustomColors.blue,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp)),
      ),
    );
  }
}
