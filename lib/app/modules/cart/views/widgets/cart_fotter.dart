import 'package:b2b_ecommerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/widgets/custom_button_feedback.dart';

class CartFooter extends StatelessWidget {
  const CartFooter({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      decoration: BoxDecoration(
        color: CustomColors.blue,
        borderRadius: BorderRadius.circular(CustomSizes.radius_12),
      ),
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
                    "Total",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: CustomColors.lightGrey,
                        ),
                  ),
                  Obx(() => Text(
                        "${controller.globalFunction.removeDecimalZeroFormat(controller.totalPrice.toDouble())}-ETB",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: CustomColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ))
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
            child: CustomButtonFeedBack(
              onTap: () {
                controller.submitOrder();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: CustomSizes.mp_v_4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Checkout",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: CustomColors.white,
                            fontSize: CustomSizes.font_12,
                          ),
                    ),
                    SizedBox(
                      width: CustomSizes.mp_w_2,
                    ),
                    Icon(
                      FontAwesomeIcons.arrowTurnDownRight,
                      size: CustomSizes.icon_size_4,
                      color: CustomColors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
