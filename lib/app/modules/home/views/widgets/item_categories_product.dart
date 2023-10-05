import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/home/data/models/catagories_model.dart';

import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class ItemCategoriesProduct extends StatelessWidget {
  const ItemCategoriesProduct(
      {Key? key, required this.category, required this.onTap})
      : super(key: key);

  final CategoriesModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(CustomSizes.mp_w_1),
      child: Material(
        color: CustomColors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(CustomSizes.radius_6),
        child: CustomButtonFeedBack(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                category.iamgelink,
                fit: BoxFit.cover,
                height: 25.h,
                width: double.infinity,
              ),
              SizedBox(
                width: CustomSizes.mp_w_4,
              ),

              ///
              buildTitles(context),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTitles(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: CustomSizes.mp_w_4,
        right: CustomSizes.mp_w_4,
        top: CustomSizes.mp_v_2,
        bottom: CustomSizes.mp_v_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.name,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: CustomSizes.font_10,
                ),
          ),
          // Text(
          //   "${product.description} Types",
          //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
          //         fontWeight: FontWeight.w300,
          //         color: CustomColors.grey,
          //         fontSize: CustomSizes.font_8,
          //       ),
          // ),
        ],
      ),
    );
  }
}
