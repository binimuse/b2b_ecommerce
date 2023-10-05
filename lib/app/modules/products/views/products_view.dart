import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/common/widgets/custom_empty_widget.dart';
import 'package:b2b_ecommerce/app/common/widgets/custom_error_widget.dart';
import 'package:b2b_ecommerce/app/common/widgets/custom_loading_widget.dart';
import 'package:b2b_ecommerce/app/modules/home/data/models/product_model.dart';
import 'package:b2b_ecommerce/app/modules/home/views/widgets/item_product.dart';
import 'package:b2b_ecommerce/app/modules/products/controllers/products_controller.dart';
import 'package:b2b_ecommerce/app/routes/app_pages.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:b2b_ecommerce/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);

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
            'Products',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.pagingController.refresh();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: CustomSizes.mp_w_6,
              right: CustomSizes.mp_w_6,
              top: CustomSizes.mp_v_2,
            ),
            child:

                ///LIST
                Obx(
              () => controller.loadingProdact.value != false
                  ? controller.shimmerLoading.buildShimmerContent()
                  : PagedGridView<int, ProdactModel>(
                      pagingController: controller.pagingController,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 100 / 170,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<ProdactModel>(
                        itemBuilder: (context, item, index) {
                          return ItemProduct(
                            product: controller.prodactData.elementAt(index),
                            onTap: () {
                              Get.toNamed(
                                Routes.PRODUCT_DETAIL,
                                arguments: {
                                  'product': controller.prodactData
                                      .elementAt(index)
                                      .id,
                                },
                              );
                            },
                          );
                        },
                        noItemsFoundIndicatorBuilder: (context) {
                          return Container(
                            color: CustomColors.white,
                            child: const CustomEmptyWidget(
                              title: 'No product Found',
                              icon: FontAwesomeIcons.emptySet,
                              description:
                                  'No registered product\'s were found ',
                              buttonText: 'Retry',
                            ),
                          );
                        },
                        newPageProgressIndicatorBuilder: (context) {
                          return Container(
                            color: CustomColors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: CustomSizes.mp_v_2),
                            child: const CustomLoadingWidget(),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) {
                          return Container(
                            color: CustomColors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: CustomSizes.mp_v_2),
                            child: const CustomLoadingWidget(),
                          );
                        },
                        noMoreItemsIndicatorBuilder: (context) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        newPageErrorIndicatorBuilder: (context) {
                          return Container(
                            color: CustomColors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: CustomSizes.mp_v_4,
                              ),
                              child: CustomErrorWidget(
                                buttonText: 'Retry'.tr,
                                description:
                                    'Please Cheack Your Internet Connection and Try Again'
                                        .tr,
                                icon: FontAwesomeIcons.cloudExclamation,
                                onRetry: () {
                                  controller.pagingController
                                      .retryLastFailedRequest();
                                },
                                title: 'Network Error'.tr,
                              ),
                            ),
                          );
                        },
                        firstPageErrorIndicatorBuilder: (context) {
                          return CustomErrorWidget(
                            buttonText: 'Retry'.tr,
                            description:
                                'Please Cheack Your Internet Connection and Try Again'
                                    .tr,
                            icon: FontAwesomeIcons.cloudExclamation,
                            onRetry: () {
                              controller.pagingController.refresh();
                            },
                            title: 'Network Error'.tr,
                          );
                        },
                      ),

                      // separatorBuilder: (BuildContext context, int index) {
                      //   return SizedBox(
                      //     height: CustomSizes.mp_v_2 * 0.8,
                      //   );
                      // },
                    ),
            ),
          ),
        ));
  }
}
