import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/my_orders/controllers/my_orders_controller.dart';
import 'package:b2b_ecommerce/app/modules/my_orders/data/model/order_model.dart';
import 'package:b2b_ecommerce/app/modules/my_orders/data/model/shipment_model.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:b2b_ecommerce/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../scan_qr_code/views/scan_qr_code.dart';

class OrderDetailView extends GetView<MyOrdersController> {
  const OrderDetailView({
    Key? key,
    this.orderHistoryModel,
    this.onTap,
  }) : super(key: key);

  final OrderHistoryModel? orderHistoryModel;
  final VoidCallback? onTap;

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
            'My Orders Detail',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanQRCodepage()),
                      );

                      //Get.to(() => ListOfDeleivery());
                    },
                    icon: Icon(
                      Icons.qr_code_scanner_rounded,
                      color: CustomColors.blue,
                      size: 9.w,
                    )),
              ),
            ),
          ],
        ),
        body: Center(
          child: Container(
            width: 90.w,
            constraints: BoxConstraints(maxHeight: 75.h),
            child: Material(
              borderRadius: BorderRadius.circular(CustomSizes.radius_6),
              elevation: 2,
              color: CustomColors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: CustomSizes.mp_v_4 * 0.7,
                    ),

                    ///BUILD HEADER
                    buildHeader(context),

                    SizedBox(
                      height: CustomSizes.mp_v_2,
                    ),

                    ///BUILD TRACKING ITEMS LIST
                    buildTrackingList(context),

                    SizedBox(
                      height: CustomSizes.mp_v_2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  buildHeader(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_w_4,
        vertical: CustomSizes.mp_v_2,
      ),
      color: CustomColors.red.withOpacity(0.1),
      child: Column(
        children: [
          Text(
            "Order ${orderHistoryModel!.oid} ",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: CustomColors.grey),
          ),
          Text(
            "Item Order Status",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CustomColors.blue,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(
            height: CustomSizes.mp_w_4,
          ),
          Row(
            children: [
              buildHeaderItem(
                context,
                FontAwesomeIcons.solidWarehouse,
                "Warehouse",
              ),
              buildHeaderItem(
                context,
                FontAwesomeIcons.solidTruckContainer,
                "Distribute",
              ),
              buildHeaderItem(
                context,
                FontAwesomeIcons.solidPerson,
                "Retailer",
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildHeaderItem(context, IconData icon, String title) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: CustomSizes.icon_size_4,
            color: CustomColors.black,
          ),
          SizedBox(
            width: CustomSizes.mp_w_2,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: CustomColors.grey,
                  fontSize: CustomSizes.font_8,
                ),
          ),
        ],
      ),
    );
  }

  buildTrackingList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, indexx) {
        return ItemOrderTrack(
          orderItemModel: orderHistoryModel!.items.elementAt(indexx),
        );
      },
      separatorBuilder: (context, indexx) {
        return SizedBox(
          height: CustomSizes.mp_w_4,
        );
      },
      itemCount: orderHistoryModel!.items.length,
    );
  }
}

class ItemOrderTrack extends StatelessWidget {
  const ItemOrderTrack({
    Key? key,
    this.orderItemModel,
  }) : super(key: key);

  final OrderItemModel? orderItemModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: 4,
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(
          CustomSizes.radius_10,
        ),
        shadowColor: CustomColors.black.withOpacity(0.4),
        child: Padding(
          padding: EdgeInsets.only(
            left: CustomSizes.mp_w_4,
            top: CustomSizes.mp_w_4,
            right: CustomSizes.mp_w_4,
            bottom: CustomSizes.mp_w_4,
          ),
          child: Column(
            children: [
              ///HEADER
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(CustomSizes.radius_6),
                    child: Image.network(
                      orderItemModel!.image,
                      width: CustomSizes.mp_w_14,
                      height: CustomSizes.mp_w_14,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: CustomSizes.mp_w_4,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderItemModel!.name.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: CustomSizes.font_10,
                                    color: CustomColors.lightBlack,
                                  ),
                        ),
                        Text(
                          "${orderItemModel!.quantity} variants",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: CustomColors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${orderItemModel!.price} Birr",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.green,
                        ),
                  ),
                ],
              ),

              SizedBox(
                height: CustomSizes.mp_v_2,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderItemModel!.shipModel.isEmpty
                        ? orderItemModel!.shipModel.length
                        : 1,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return buildDetailsRow(
                        context,
                        orderItemModel!.shipModel.elementAt(index),
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
                  SizedBox(
                    height: CustomSizes.mp_v_4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material buildTrackIcon(IconData icon, Color color) {
    return Material(
      borderRadius: BorderRadius.circular(
        CustomSizes.radius_6,
      ),
      color: color.withOpacity(0.2),
      child: SizedBox(
        width: CustomSizes.icon_size_12,
        height: CustomSizes.icon_size_12,
        child: Center(
          child: Icon(
            icon,
            size: CustomSizes.icon_size_4,
            color: color,
          ),
        ),
      ),
    );
  }

  buildDetailsRow(
    BuildContext context,
    ShipModel shipModel,
  ) {
    return Column(
      children: [
        SizedBox(
          height: CustomSizes.mp_v_4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Shipment Information",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CustomColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: CustomSizes.font_16,
                  ),
            ),
            Text(
              "",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Status :- ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
            Text(
              shipModel.status,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'From :- ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
            Text(
              shipModel.from,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'To :- ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
            Text(
              shipModel.to,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
          ],
        ),
        SizedBox(
          height: CustomSizes.mp_v_4,
        ),
        Row(
          children: [
            shipModel.from == "Warehouse"
                ? buildTrackIcon(
                    FontAwesomeIcons.solidWarehouse,
                    shipModel.status == "PENDING"
                        ? CustomColors.yellow
                        : shipModel.status == "DELIVERED"
                            ? CustomColors.blue
                            : shipModel.status == "SHIPPED"
                                ? CustomColors.blue
                                : CustomColors.blue,
                  )
                : shipModel.from == "Distributor"
                    ? buildTrackIcon(
                        FontAwesomeIcons.solidWarehouse,
                        shipModel.status == "PENDING"
                            ? CustomColors.blue
                            : shipModel.status == "DELIVERED"
                                ? CustomColors.blue
                                : shipModel.status == "SHIPPED"
                                    ? CustomColors.blue
                                    : CustomColors.blue,
                      )
                    : const SizedBox(),
            const Expanded(
              child: Center(
                child: Divider(
                  color: CustomColors.grey,
                ),
              ),
            ),
            shipModel.from == "Warehouse"
                ? buildTrackIcon(
                    FontAwesomeIcons.solidTruckContainer,
                    shipModel.status == "PENDING"
                        ? CustomColors.grey
                        : shipModel.status == "DELIVERED"
                            ? CustomColors.green
                            : shipModel.status == "SHIPPED"
                                ? CustomColors.blue
                                : CustomColors.blue,
                  )
                : shipModel.from == "Distributor"
                    ? buildTrackIcon(
                        FontAwesomeIcons.solidTruckContainer,
                        shipModel.status == "PENDING"
                            ? CustomColors.yellow
                            : shipModel.status == "DELIVERED"
                                ? CustomColors.blue
                                : shipModel.status == "SHIPPED"
                                    ? CustomColors.blue
                                    : CustomColors.blue,
                      )
                    : const SizedBox(),
            const Expanded(
              child: Center(
                child: Divider(
                  color: CustomColors.grey,
                ),
              ),
            ),
            shipModel.from == "Warehouse"
                ? buildTrackIcon(
                    FontAwesomeIcons.solidUser,
                    shipModel.status == "PENDING"
                        ? CustomColors.grey
                        : shipModel.status == "DELIVERED"
                            ? CustomColors.grey
                            : shipModel.status == "SHIPPED"
                                ? CustomColors.yellow
                                : CustomColors.blue,
                  )
                : shipModel.from == "Distributor"
                    ? buildTrackIcon(
                        FontAwesomeIcons.solidUser,
                        shipModel.status == "PENDING"
                            ? CustomColors.grey
                            : shipModel.status == "DELIVERED"
                                ? CustomColors.green
                                : shipModel.status == "SHIPPED"
                                    ? CustomColors.yellow
                                    : CustomColors.blue,
                      )
                    : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
