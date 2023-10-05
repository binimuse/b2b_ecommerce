import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/categories/views/widgets/item_category.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/fake_data.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:b2b_ecommerce/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({Key? key}) : super(key: key);

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
          'Categories',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: CustomSizes.mp_w_4,
          right: CustomSizes.mp_w_4,
          top: CustomSizes.mp_v_2,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => ItemCategory(
            category: FakeData.fakeCategories.elementAt(index),
            onTap: () {},
          ),
          itemCount: FakeData.fakeCategories.length,
        ),
      ),
    );
  }
}
