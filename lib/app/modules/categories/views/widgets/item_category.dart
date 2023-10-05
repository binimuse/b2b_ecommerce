import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/modules/home/data/models/category.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({Key? key, required this.category, required this.onTap})
      : super(key: key);

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        CustomSizes.mp_w_4 * 0.5,
      ),
      child: Material(
        color: CustomColors.white,
        shadowColor: CustomColors.red.withOpacity(0.2),
        elevation: 3,
        borderRadius: BorderRadius.circular(CustomSizes.radius_6),
        child: CustomButtonFeedBack(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    category.iconData,
                    size: CustomSizes.icon_size_16,
                    color: CustomColors.blue,
                  ),
                ),
                SizedBox(
                  height: CustomSizes.mp_w_2,
                ),
                Text(
                  category.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: CustomSizes.font_10),
                ),
                SizedBox(
                  height: CustomSizes.mp_w_4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
