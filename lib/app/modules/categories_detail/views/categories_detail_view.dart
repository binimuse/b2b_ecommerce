import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/home/views/widgets/item_categories_product.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../helper/keyboard.dart';
import '../controllers/categories_detail_controller.dart';

class CategoriesDetailView extends GetView<CategoriesDetailController> {
  const CategoriesDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Categories',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          buildHeaderSearchBar(),
          Obx(() => controller.loading.value != true
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  color: Colors.white,
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                    ),
                    childAspectRatio: 0.63,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      controller.catagoriDetailData.length,
                      (index) {
                        return ItemCategoriesProduct(
                          category:
                              controller.catagoriDetailData.elementAt(index),
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator())),
        ]),
      ),
    );
  }

  Material buildHeaderSearchBar() {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          color: Colors.white,
          padding:
              EdgeInsets.only(left: 4.w, right: 4.w, bottom: 3.h, top: 1.h),
          child: TextField(
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(
                color: const Color(0xff757A80),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              alignLabelWithHint: true,
              prefixIcon: Icon(
                Icons.search,
                size: 6.w,
                color: Colors.black45,
              ),
              fillColor: Colors.white,
              border: InputBorder.none,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                borderSide: BorderSide(
                  color: CustomColors.blue,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
                borderSide: BorderSide(
                  color: CustomColors.blue,
                ),
              ),
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 5.w,
                horizontal: 2.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
