import 'package:b2b_ecommerce/app/common/widgets/warning_dialog.dart';
import 'package:b2b_ecommerce/app/modules/product_detail/data/model/skul_model.dart';
import 'package:b2b_ecommerce/app/modules/product_detail/data/model/vari_model.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/product_detail_controller.dart';

class ItemVariant extends StatefulWidget {
  const ItemVariant({
    Key? key,
    required this.sku,
    required this.imageLink,
    required this.contoller,
  }) : super(key: key);

  final SkuModel sku;
  final String imageLink;
  final ProductDetailController contoller;
  @override
  State<ItemVariant> createState() => _ItemVariantState();
}

class _ItemVariantState extends State<ItemVariant> {
  ///
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() => widget.contoller.loading.value
        ? SizedBox(
            width: double.infinity,
            child: Material(
              elevation: 2,
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(
                CustomSizes.radius_10,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: CustomSizes.mp_w_6,
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
                          borderRadius:
                              BorderRadius.circular(CustomSizes.radius_4),
                          child: Image.network(
                            widget.imageLink,
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
                                widget.sku.sku.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: CustomColors.lightBlack,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Get.dialog(
                              WarningDialog(
                                leftButtonText: 'No',
                                rightButtonText: 'Yes',
                                title: ' Add to Cart',
                                description:
                                    'Are you sure you want to Add to Cart  ${widget.sku.sku}  ?',
                                onLeftButtonTap: () {
                                  Get.back();
                                },
                                onRightButtonTap: () {
                                  ///POP DIALOG

                                  Get.back();
                                  Get.back();
                                  widget.contoller.addToCart(widget.sku.id);
                                },
                              ),
                            );
                          }),
                          child: Icon(
                            FontAwesomeIcons.cartPlus,
                            size: CustomSizes.icon_size_6 * 0.9,
                            color: CustomColors.blue,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: CustomSizes.mp_v_2,
                    ),

                    ///EXPANDABLE DETAILS HEADER
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Details",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: CustomColors.blue,
                                    fontSize: CustomSizes.font_10,
                                  ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        SizedBox(
                          width: CustomSizes.mp_w_4,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: Icon(
                            isExpanded
                                ? FontAwesomeIcons.chevronUp
                                : FontAwesomeIcons.chevronDown,
                            color: CustomColors.grey,
                            size: CustomSizes.icon_size_4,
                          ),
                        ),
                      ],
                    ),

                    ///EXPANDABLE DETAILS BODY
                    isExpanded
                        ? Padding(
                            padding: EdgeInsets.only(right: CustomSizes.mp_w_4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: CustomSizes.mp_v_2,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: List.generate(
                                      widget.sku.variModels.length,
                                      (index) {
                                        return buildDetailsRow(
                                          context,
                                          widget.sku.variModels[index],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: CustomSizes.mp_v_2,
                                ),
                                Text(
                                  "${widget.sku.price.toString()} : " "ETB",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.green,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          )
        : SizedBox());
  }

  buildDetailsRow(BuildContext context, VariModel variModel) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              variModel.attributename,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CustomColors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Text(
              variModel.attributeValues,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
          ],
        ),
        SizedBox(
          height: CustomSizes.mp_v_1,
        ),
        const Divider(
          height: 1,
          color: CustomColors.lightGrey,
        )
      ],
    );
  }
}
