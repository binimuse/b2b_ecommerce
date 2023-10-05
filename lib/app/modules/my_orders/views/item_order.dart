// ignore_for_file: unnecessary_null_comparison

import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../data/model/order_model.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder(
      {Key? key, required this.orderHistoryModel, required this.onTap})
      : super(key: key);

  final OrderHistoryModel orderHistoryModel;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.white,
      borderRadius: BorderRadius.circular(CustomSizes.radius_6),
      elevation: 4,
      shadowColor: CustomColors.black.withOpacity(0.2),
      child: CustomButtonFeedBack(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CustomSizes.mp_w_4,
            vertical: CustomSizes.mp_w_2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///BUILD ICON CONTAINER
              buildIcon(),

              SizedBox(
                width: CustomSizes.mp_w_4,
              ),

              ///BUILD ITEM INFO
              buildItemInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Material buildIcon() {
    return Material(
      color: CustomColors.red.withOpacity(0.05),
      borderRadius: BorderRadius.circular(CustomSizes.radius_8),
      child: Padding(
        padding: EdgeInsets.all(
          CustomSizes.mp_w_6,
        ),
        child: Icon(
          FontAwesomeIcons.layerGroup,
          size: CustomSizes.icon_size_8,
          color: CustomColors.blue,
        ),
      ),
    );
  }

  buildItemInfo(context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Order id ${orderHistoryModel.oid}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: CustomColors.blue,
                        fontSize: CustomSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Material(
                color: CustomColors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(CustomSizes.radius_6 * 6),
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: CustomSizes.mp_w_4,
                    vertical: CustomSizes.mp_v_1 / 2,
                  ),
                  child: Text(
                    orderHistoryModel.items.length.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorUtil.darken(CustomColors.red, 0.2),
                          fontSize: CustomSizes.font_8,
                        ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: CustomSizes.mp_v_1 / 2,
          ),
          Row(
            children: [
              Text(
                "Total",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: CustomColors.grey,
                      fontSize: CustomSizes.font_8,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(
                width: CustomSizes.mp_w_1,
              ),
              Text(
                "${orderHistoryModel.total_price}ETB",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: CustomColors.green,
                      fontSize: CustomSizes.font_10,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              orderHistoryModel.created_at_human == null
                  ? const SizedBox()
                  : Text(
                      orderHistoryModel.created_at_human,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: CustomColors.grey,
                            fontSize: CustomSizes.font_8,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
            ],
          ),
          SizedBox(
            height: CustomSizes.mp_v_2,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(CustomSizes.radius_12),
            child: LinearProgressIndicator(
              minHeight: CustomSizes.icon_size_2 * 0.8,
              color: CustomColors.blue,
              value: 0.7,
              backgroundColor: CustomColors.blue.withOpacity(0.05),
            ),
          ),
          SizedBox(
            height: CustomSizes.mp_v_1 / 2,
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Text(
                "34%",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: CustomColors.blue,
                      fontSize: CustomSizes.font_8,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
