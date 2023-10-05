import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:b2b_ecommerce/app/modules/cart/data/model/cart_model.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ItemVariantPlusMinus extends StatelessWidget {
  const ItemVariantPlusMinus({
    Key? key,
    required this.index,
    required this.controller,
    required this.cartModel,
  }) : super(key: key);

  final int index;

  final CartController controller;
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: 1,
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(
          CustomSizes.radius_10,
        ),
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
                      controller.cartList[index].image,
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
                          controller.cartList[index].prodactName,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: CustomSizes.font_10,
                                    color: CustomColors.lightBlack,
                                  ),
                        ),
                        Text(
                          controller.cartList[index].prodactDesc,
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: CustomColors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  ///BUILD ITEMS COUNTER
                  buiuldItemsCounter(context),
                ],
              ),

              SizedBox(
                height: CustomSizes.mp_v_2,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " Price:- ${controller.cartList[index].price.toString()}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.green,
                        ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
              buildDeleteButton(context),
              SizedBox(
                height: CustomSizes.mp_v_2,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Detail",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: CustomColors.blue,
                        ),
                  ),
                  const Expanded(
                    child: SizedBox(),
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
                    itemCount: cartModel.variModels.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return buildDetailsRow(context, index);
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
                    height: CustomSizes.mp_v_2,
                  ),
                ],
              ),

              ///EXPANDABLE DETAILS HEADER
              SizedBox(
                height: CustomSizes.mp_v_2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildDeleteButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Widget cancelButton = TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  const Text('No', style: TextStyle(color: CustomColors.blue)));
          Widget continueButton = TextButton(
              onPressed: () {
                controller.deleteCartItem(index);
                Navigator.pop(context);
              },
              child: const Text('Yes',
                  style: TextStyle(color: CustomColors.blue)));
          Get.dialog(AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              'Warning, deleting an item',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            content: const Text(
                'Are you sure to delete this item from your Cart ?',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            actions: [
              cancelButton,
              continueButton,
            ],
          ));

          Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Colors.grey[300]!)),
            child: const Icon(Icons.delete, color: Colors.red, size: 20),
          );
        },
        icon: Icon(Icons.delete, color: Colors.grey[600]));
  }

  buiuldItemsCounter(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomSizes.radius_4),
        color: CustomColors.red.withOpacity(0.1),
      ),
      child: Row(
        children: [
          CustomButtonFeedBack(
            child: Padding(
              padding: EdgeInsets.all(CustomSizes.mp_w_2),
              child: Icon(
                FontAwesomeIcons.minus,
                size: CustomSizes.icon_size_4 * 0.8,
                color: CustomColors.blue,
              ),
            ),
            onTap: () {
              controller.updateCartAmount('minus', index);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_2),
            child: Obx(
              () => controller.isLoading.value != true
                  ? Text(
                      '${controller.cartList[index].qty}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.blue,
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
          CustomButtonFeedBack(
            child: Padding(
              padding: EdgeInsets.all(CustomSizes.mp_w_2),
              child: Icon(
                FontAwesomeIcons.plus,
                size: CustomSizes.icon_size_4 * 0.8,
                color: CustomColors.blue,
              ),
            ),
            onTap: () {
              controller.updateCartAmount('plus', index);
            },
          ),
        ],
      ),
    );
  }

  buildDetailsRow(BuildContext context, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            cartModel.variModels[index].attributename,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CustomColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: CustomSizes.font_10,
                ),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        Text(
          cartModel.variModels[index].attributeValues,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: CustomColors.grey,
                fontSize: CustomSizes.font_10,
              ),
        ),
      ],
    );
  }
}
