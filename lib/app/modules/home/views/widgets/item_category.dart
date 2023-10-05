import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/catagories_model.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({Key? key, required this.category, required this.onTap})
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    category.iamgelink,
                  ),
                ),
                SizedBox(
                  width: CustomSizes.mp_w_4,
                ),
                Text(
                  category.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: CustomSizes.font_10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
