// ignore_for_file: must_be_immutable

import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/home/views/widgets/item_category.dart';
import 'package:b2b_ecommerce/app/modules/home/views/widgets/item_product.dart';
import 'package:b2b_ecommerce/app/modules/home/views/widgets/wallet_card.dart';
import 'package:b2b_ecommerce/app/routes/app_pages.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../wallet/controllers/wallet_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  WalletController walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///BUILD ACT HEADER
              buildActHeader(context),

              ///BUILD SEARCH HEADER
              buildSearchHeader(context),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ///BUILD WALLET CARD

                      const WalletCard(),

                      ///CATEGORIES LIST
                      buildCategories(context),

                      ///PRODUCTS LIST
                      buildProducts(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildActHeader(context) {
    return Column(
      children: [
        SizedBox(
          height: CustomSizes.mp_v_2,
        ),
        Text(
          "ANT",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: CustomColors.grey, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: CustomSizes.mp_v_2,
        ),
      ],
    );
  }

  buildSearchHeader(context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Material(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.SEARCH);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        left: 4.w, right: 4.w, bottom: 3.h, top: 1.h),
                    child: TextField(
                      readOnly: true,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.SEARCH);
                          },
                          child: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: CustomColors.grey,
                            size: CustomSizes.icon_size_4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: CustomSizes.mp_w_2,
            ),
            Material(
              elevation: 2,
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(CustomSizes.radius_4),
              child: CustomButtonFeedBack(
                onTap: () async {
                  Get.toNamed(Routes.NOTIFICATION);
                },
                child: Padding(
                  padding: EdgeInsets.all(CustomSizes.mp_w_4 * 0.8),
                  child: Icon(
                    FontAwesomeIcons.solidBell,
                    size: CustomSizes.icon_size_6 * 0.8,
                    color: CustomColors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: CustomSizes.mp_v_4,
        ),
      ],
    );
  }

  buildCategories(context) {
    return Column(
      children: [
        SizedBox(
          height: CustomSizes.mp_v_2,
        ),

        ///HEADER
        Row(
          children: [
            Text(
              "Categories",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            CustomButtonFeedBack(
              onTap: () {
                Get.toNamed(Routes.CATEGORIES);
              },
              child: Padding(
                padding: EdgeInsets.all(CustomSizes.mp_w_2),
                child: Text(
                  "View All",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: CustomColors.blue,
                        fontSize: CustomSizes.font_10,
                      ),
                ),
              ),
            ),
          ],
        ),

        ///LIST
        Obx(
          () => controller.loading.value != false
              ? controller.shimmerLoading.buildShimmerTrending(5)
              : SizedBox(
                  width: double.infinity,
                  height: 18.h,
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    scrollDirection: Axis.horizontal,
                    crossAxisSpacing: CustomSizes.mp_w_2 / 2,
                    itemCount: controller.catagoriData.length,
                    itemBuilder: (context, index) {
                      return ItemCategory(
                        category: controller.catagoriData.elementAt(index),
                        onTap: () {
                          Get.toNamed(Routes.CATEGORIES_DETAIL,
                              arguments:
                                  controller.catagoriData.elementAt(index).id);
                        },
                      );
                    },
                  ),
                ),
        )
      ],
    );
  }

  buildProducts(context) {
    return Column(
      children: [
        SizedBox(
          height: CustomSizes.mp_v_4,
        ),

        ///HEADER
        Row(
          children: [
            Text(
              "Products",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CustomColors.grey,
                    fontSize: CustomSizes.font_10,
                  ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            CustomButtonFeedBack(
              onTap: () {
                Get.toNamed(Routes.PRODUCTS);
              },
              child: Padding(
                padding: EdgeInsets.all(CustomSizes.mp_w_2),
                child: Text(
                  "View All",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: CustomColors.blue,
                        fontSize: CustomSizes.font_10,
                      ),
                ),
              ),
            ),
          ],
        ),

        ///LIST
        Obx(
          () => controller.loadingProdact.value != false
              ? controller.shimmerLoading.buildShimmerContent()
              : MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: CustomSizes.mp_w_2 / 2,
                  itemCount: controller.ProdactData.length,
                  itemBuilder: (context, index) {
                    return ItemProduct(
                      product: controller.ProdactData.elementAt(index),
                      onTap: () {
                        Get.toNamed(
                          Routes.PRODUCT_DETAIL,
                          arguments: {
                            'product':
                                controller.ProdactData.elementAt(index).id,
                          },
                        );
                      },
                    );
                  },
                ),
        )
      ],
    );
  }
}
