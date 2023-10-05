import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/common/widgets/dialog_payment.dart';
import 'package:b2b_ecommerce/app/routes/app_pages.dart';

import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../wallet/controllers/wallet_controller.dart';

import 'package:get/get.dart';

class WalletCard extends GetView<WalletController> {
  const WalletCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 15.h,
        decoration: BoxDecoration(
          color: CustomColors.blue,
          borderRadius: BorderRadius.circular(CustomSizes.radius_12),
        ),
        child: Obx(() => GestureDetector(
              onTap: (() {
                controller.gwtwalletammount();
                controller.update();
              }),
              child: Row(
                children: [
                  ///SCHEDULE DATE
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wallet Balance",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: CustomColors.lightGrey,
                                    ),
                          ),
                          Text(
                            "${controller.walletamount.value} ETB",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: CustomColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),

                  ///MIDDLE DIVIDER
                  Column(
                    children: [
                      SizedBox(
                        height: CustomSizes.icon_size_6 / 2,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            FontAwesomeIcons.solidCircleHalf,
                            size: CustomSizes.icon_size_6,
                            color: CustomColors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: CustomSizes.mp_w_4,
                        ),
                      ),
                      SizedBox(
                        height: CustomSizes.icon_size_6 / 2,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            FontAwesomeIcons.solidCircleHalf,
                            size: CustomSizes.icon_size_6,
                            color: CustomColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///BIO TICKET NUMBER
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          elevation: 2,
                          color: CustomColors.white,
                          borderRadius:
                              BorderRadius.circular(CustomSizes.radius_4),
                          child: CustomButtonFeedBack(
                            onTap: () {
                              Get.dialog(
                                const DialogPayment(),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(CustomSizes.mp_w_4 * 0.7),
                              child: Icon(
                                FontAwesomeIcons.plus,
                                size: CustomSizes.icon_size_4,
                                color: CustomColors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: CustomSizes.mp_w_6,
                        ),
                        Material(
                          elevation: 2,
                          color: CustomColors.white,
                          borderRadius:
                              BorderRadius.circular(CustomSizes.radius_4),
                          child: CustomButtonFeedBack(
                            onTap: () {
                              controller.gwtwalletammount();
                              controller.update();
                              Get.toNamed(Routes.WALLET);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(CustomSizes.mp_w_4 * 0.7),
                              child: Icon(
                                FontAwesomeIcons.solidCreditCard,
                                size: CustomSizes.icon_size_4,
                                color: CustomColors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
