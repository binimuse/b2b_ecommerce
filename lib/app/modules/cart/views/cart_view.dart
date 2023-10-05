// ignore_for_file: sort_child_properties_last

import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/cart/views/widgets/cart_fotter.dart';
import 'package:b2b_ecommerce/app/modules/cart/views/widgets/item_variant_plus_minus.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:b2b_ecommerce/constant/cache_image_network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../../helper/keyboard.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: PagesUtil.getAppBarLightStyle(),
        toolbarHeight: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(CustomSizes.mp_v_2),
          child: Column(
            children: [
              ///BUILD APP BAR
              buildAppBar(context),

              SizedBox(
                height: CustomSizes.mp_w_4,
              ),

              ///LIST OF CART ITEMS
              Obx(
                () => controller.loadingCart.value == true
                    ? const Center(child: CircularProgressIndicator())
                    : controller.cartList.isEmpty
                        ? Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildCacheNetworkImage(
                                      url:
                                          "https://www.gamkart.com/frontend/img/empty-cart.png",
                                      width: 290),
                                  ElevatedButton(
                                    child: const Text('Go Back',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              CustomColors.blue),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10)),
                                    ),
                                  )
                                ]),
                          )
                        : Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: controller.cartList.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return ItemVariantPlusMinus(
                                  index: index,
                                  controller: controller,
                                  cartModel: controller.cartList[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: CustomSizes.mp_v_1,
                                  ),
                                  child: const Divider(
                                    height: 1,
                                    color: CustomColors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
              ),
              SizedBox(
                height: CustomSizes.mp_w_4,
              ),

              ///PAGE FOOTER
              Obx(
                () => controller.cartList.isEmpty
                    ? const SizedBox()
                    : CartFooter(
                        controller: controller,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_w_4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (() {
              Get.back();
              KeyboardUtil.hideKeyboard(context);
            }),
            child: Padding(
              padding: EdgeInsets.all(CustomSizes.mp_w_2),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(CustomSizes.radius_6),
                child: Padding(
                  padding: EdgeInsets.all(
                    CustomSizes.mp_w_4,
                  ),
                  child: CustomButtonFeedBack(
                    onTap: () {
                      Get.back();
                      KeyboardUtil.hideKeyboard(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: CustomColors.blue,
                      size: CustomSizes.icon_size_4,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            'Cart',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Padding(
            padding: EdgeInsets.all(CustomSizes.mp_w_2),
            child: Material(
              elevation: 4,
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(CustomSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.all(
                  CustomSizes.mp_w_4,
                ),
                child: CustomButtonFeedBack(
                  onTap: () {
                    Get.back();
                    KeyboardUtil.hideKeyboard(context);
                  },
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.lightClockRotateLeft,
                      color: CustomColors.blue,
                      size: CustomSizes.icon_size_4,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
