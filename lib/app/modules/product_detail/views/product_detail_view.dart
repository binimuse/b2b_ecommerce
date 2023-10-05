import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/product_detail/views/widgets/images_slider.dart';
import 'package:b2b_ecommerce/app/modules/product_detail/views/widgets/item_variant.dart';
import 'package:b2b_ecommerce/app/routes/app_pages.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:b2b_ecommerce/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  ProductDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: PagesUtil.getAppBarLightStyle(),
        toolbarHeight: 0.0,
      ),
      //  bottomSheet: buildDraggableScrollableSheet(),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            ///MAIN PAGE
            Column(
              children: [
                SizedBox(
                  height: CustomSizes.mp_v_2,
                ),

                ///APP BAR
                buildAppBar(context),

                ///IMAGE SLIDER
                Obx(() => controller.loadingimage.value
                    ? buildImageSlider()
                    : const SizedBox()),
              ],
            ),

            ///BOTTOM SHEET
            Obx(() => controller.loading.value
                ? buildDraggableScrollableSheet()
                : const SizedBox())
          ],
        ),
      ),
    );
  }

  DraggableScrollableSheet buildDraggableScrollableSheet() {
    return DraggableScrollableSheet(
      //  expand: false,
      maxChildSize: 0.8,
      initialChildSize: 0.6,
      minChildSize: 0.6,
      builder: (context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(CustomSizes.radius_12 * 3),
              topRight: Radius.circular(CustomSizes.radius_12 * 3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: 6,
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: ListView(
              controller: scrollController,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: CustomSizes.mp_w_8,
                    left: CustomSizes.mp_w_8,
                    right: CustomSizes.mp_w_8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.name.value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: CustomColors.lightBlack,
                            ),
                      ),
                      Text(
                        controller.description.value.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w300,
                              color: CustomColors.grey,
                            ),
                      ),
                      SizedBox(
                        height: CustomSizes.mp_v_1,
                      ),
                      const Divider(
                        height: 1,
                        color: CustomColors.lightGrey,
                      ),
                      SizedBox(
                        height: CustomSizes.mp_v_2,
                      ),
                      Text(
                        "Details",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w300,
                              color: CustomColors.blue,
                            ),
                      ),
                      SizedBox(
                        height: CustomSizes.mp_v_2,
                      ),
                      buildDetailTextRow(context),

                      SizedBox(
                        height: CustomSizes.mp_v_4,
                      ),
                      Text(
                        "Products Items",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w300,
                              color: CustomColors.grey,
                            ),
                      ),
                      SizedBox(
                        height: CustomSizes.mp_v_1,
                      ),

                      ///EXPANDABLE PRODUCT DETAIL
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.sku.length,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            return ItemVariant(
                              sku: controller.sku[index],
                              imageLink: controller.imagelink[0],
                              contoller: controller,
                            );
                          });
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: CustomColors.blue,
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox buildImageSlider() {
    return SizedBox(
      height: 35.h,
      child: ImagesSlider(
          scrollDuration: const Duration(milliseconds: 1500),
          imagePaths: controller.imagelink),
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
            'Detail',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Padding(
            padding: EdgeInsets.all(CustomSizes.mp_w_2),
            child: Material(
              elevation: 4,
              color: CustomColors.blue,
              borderRadius: BorderRadius.circular(CustomSizes.radius_6),
              child: CustomButtonFeedBack(
                onTap: () {
                  // Get.dialog(
                  //   const DialogFilter(),
                  // );

                  Get.toNamed(Routes.CART);
                },
                child: Padding(
                  padding: EdgeInsets.all(
                    CustomSizes.mp_w_4,
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.cartPlus,
                      color: CustomColors.white,
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

  buildDetailTextRow(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          FontAwesomeIcons.checkDouble,
          size: CustomSizes.icon_size_4 * 0.9,
          color: CustomColors.blue,
        ),
        SizedBox(
          width: CustomSizes.mp_w_4,
        ),
        Expanded(
          child: Text(
            controller.description.value.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CustomColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: CustomSizes.font_10,
                ),
          ),
        ),
      ],
    );
  }
}
