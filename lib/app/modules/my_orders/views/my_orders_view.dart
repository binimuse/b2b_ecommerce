import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/my_orders/views/item_order.dart';
import 'package:b2b_ecommerce/app/modules/order_detail/views/order_detail_view.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../../helper/keyboard.dart';
import '../controllers/my_orders_controller.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: PagesUtil.getAppBarLightStyle(),
        leading: Padding(
          padding: EdgeInsets.all(CustomSizes.mp_w_2),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(CustomSizes.radius_6),
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
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.loadingOrderHistory.isTrue
          ? ListView.separated(
              padding: EdgeInsets.only(
                left: CustomSizes.mp_w_4,
                right: CustomSizes.mp_w_4,
                top: CustomSizes.mp_v_2,
              ),
              itemBuilder: (context, index) {
                return ItemOrder(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetailView(
                                  orderHistoryModel:
                                      controller.orderData[index],
                                )));
                  },
                  orderHistoryModel: controller.orderData[index],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: CustomSizes.mp_v_1,
                );
              },
              itemCount: controller.orderData.length,
            )
          : const Center(child: CircularProgressIndicator())),
    );
  }
}
