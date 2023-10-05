import 'package:b2b_ecommerce/app/common/widgets/custom_carousel_slider.dart';
import 'package:b2b_ecommerce/app/common/widgets/custom_normal_button.dart';
import 'package:b2b_ecommerce/app/common/widgets/custom_normal_button_border.dart';
import 'package:b2b_ecommerce/app/modules/on_boarding/views/widgets/carousel_item.dart';
import 'package:b2b_ecommerce/app/routes/app_pages.dart';
import 'package:b2b_ecommerce/config/theme/app_assets.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: PagesUtil.getAppBarLightStyle(),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ///ACT HEADER
            buildActHeader(context),

            ///BUILD CAROUSEL SLIDER
            Expanded(
              child: buildCarouselSlider(context),
            ),

            ///NEXT BUTTON
            buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Obx buildNextButton(BuildContext context,) {
    return Obx(() {
      if (controller.currentPage.value == 2) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: CustomSizes.mp_w_6,
            right: CustomSizes.mp_w_6,
            top: CustomSizes.mp_w_10,
            bottom: CustomSizes.mp_w_6,
          ),
          child: CustomNormalButton(
            text: "Start",
            textStyle: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: CustomColors.white,
            ),
            bgColor: CustomColors.blue,
            rightIcon: Icon(
              FontAwesomeIcons.arrowRight,
              color: CustomColors.white,
              size: CustomSizes.icon_size_4 * 0.8,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: CustomSizes.mp_v_2,
              vertical: CustomSizes.mp_v_2 * 0.8,
            ),
            onPressed: () {
              Get.toNamed(Routes.SIGN_IN);
            },
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: CustomSizes.mp_w_6,
            right: CustomSizes.mp_w_6,
            top: CustomSizes.mp_w_10,
            bottom: CustomSizes.mp_w_6,
          ),
          child: CustomNormalButtonBorder(
            text: "Next",
            textStyle: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: CustomColors.blue,
            ),
            borderColor: CustomColors.blue,
            bgColor: CustomColors.white,
            rightIcon: Icon(
              FontAwesomeIcons.arrowRight,
              color: CustomColors.blue,
              size: CustomSizes.icon_size_4 * 0.8,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: CustomSizes.mp_v_2,
              vertical: CustomSizes.mp_v_2 * 0.8,
            ),
            onPressed: () {
              int n = controller.currentPage.value;

              if (controller.currentPage.value < 2) {
                n = controller.currentPage.value + 1;
              }

              controller.tController.animateToPage(
                n,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
          ),
        );
      }
    });
  }

  Text buildActHeader(BuildContext context) {
    return Text(
      "ACT",
      textAlign: TextAlign.center,
      style: Theme
          .of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(color: CustomColors.blue, fontWeight: FontWeight.bold),
    );
  }

  buildCarouselSlider(context) {
    return CarouselSlider(
      height: null,
      scrollDuration: const Duration(microseconds: 500),
      dotTopMargin: CustomSizes.mp_v_6,
      autoScroll: false,
      onPageChanged: (currentPage) {
        controller.setPageViewPage(currentPage);
      },
      onPageControllerInit: (PageController con) {
        controller.tController = con;
      },
      children: const [
        CarouselItem(
          title: "To Your Place",
          subTitle:
          "We bring your order to your own place , also make you be able to track your orders",
          image: AppAssets.locationSearchPana,
        ),
        CarouselItem(
          title: "To Your Place",
          subTitle:
          "We bring your order to your own place , also make you be able to track your orders",
          image: AppAssets.logisticsPana,
        ),
        CarouselItem(
          title: "To Your Place",
          subTitle:
          "We bring your order to your own place , also make you be able to track your orders",
          image: AppAssets.deliveryAddressPana,
        ),
      ],
    );
  }
}
