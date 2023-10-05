import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_8),
      child: Column(
        children: [
          SizedBox(
            height: CustomSizes.mp_v_2,
          ),
          Expanded(
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: CustomSizes.mp_v_6,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: CustomColors.black),
          ),
          SizedBox(
            height: CustomSizes.mp_v_1 / 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_8),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: CustomColors.grey, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
