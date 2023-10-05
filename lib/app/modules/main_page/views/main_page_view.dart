import 'package:b2b_ecommerce/app/modules/home/views/home_view.dart';
import 'package:b2b_ecommerce/app/modules/profile/views/profile_view.dart';
import 'package:b2b_ecommerce/app/routes/app_pages.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: buildBottomAppBar(),
      body: SafeArea(
        child: Obx(() {
          return IndexedStack(
            index: controller.currentPageIndex.value,
            children: [
              HomeView(),
               ProfileView(),
            ],
          );
        }),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(Routes.CART);
      },
      backgroundColor: CustomColors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(CustomSizes.radius_8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 2),
        child: Icon(
          FontAwesomeIcons.solidCartShopping,
          color: CustomColors.white,
          size: CustomSizes.icon_size_4,
        ),
      ),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      color: CustomColors.white,
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(CustomSizes.radius_8),
          ),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(CustomSizes.radius_8),
          ),
        ),
      ),
      notchMargin: CustomSizes.mp_w_2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: CustomSizes.mp_v_1,
        ),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.solidStore,
                  color: controller.currentPageIndex.value == 0
                      ? CustomColors.blue
                      : CustomColors.grey,
                  size: CustomSizes.icon_size_8 * 0.9,
                ),
                onPressed: () {
                  controller.changeBottomPage(0);
                },
              ),
              SizedBox(
                width: CustomSizes.mp_w_16,
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.solidSquareUser,
                  color: controller.currentPageIndex.value == 1
                      ? CustomColors.blue
                      : CustomColors.grey,
                  size: CustomSizes.icon_size_8 * 0.9,
                ),
                onPressed: () {
                  controller.changeBottomPage(1);
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
