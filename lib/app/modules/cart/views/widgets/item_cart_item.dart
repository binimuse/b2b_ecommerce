import 'package:b2b_ecommerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/constant/cache_image_network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemCartWidget extends StatefulWidget {
  const ItemCartWidget({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  final int index;

  final CartController controller;
  @override
  State<ItemCartWidget> createState() => _ItemCartWidgetState();
}

class _ItemCartWidgetState extends State<ItemCartWidget> {
  ///
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_v_2,
        vertical: CustomSizes.mp_v_2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomSizes.radius_6),
        color: CustomColors.lightGrey.withOpacity(0.5),
      ),
      child: Column(
        children: [
          ///ITEM HEADER MAIN CONTAINER
          buildItemMainContainer(context),

          ///ITEM VARIANTS CONTAINER
          isExpanded ? buildItemVariants(context) : const SizedBox(),
        ],
      ),
    );
  }

  Widget buildItemVariants(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: CustomSizes.mp_v_2,
        ),
        // ListView.separated(
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemBuilder: (context, index) {
        //     return ItemVariantPlusMinus();
        //   },
        //   separatorBuilder: (context, index) {
        //     return SizedBox(
        //       height: CustomSizes.mp_v_2,
        //     );
        //   },
        //   itemCount: 3,
        // ),
        SizedBox(
          height: CustomSizes.mp_v_2,
        ),
      ],
    );
  }

  Row buildItemMainContainer(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///LETTER ICON
        buildLetterIcon(context),

        SizedBox(
          width: CustomSizes.mp_w_4,
        ),

        ///BUILD HEADER DETAILS
        buildHedaerDeatils(context),

        IconButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          icon: Icon(
            isExpanded
                ? FontAwesomeIcons.solidChevronUp
                : FontAwesomeIcons.solidChevronDown,
            color: CustomColors.blue,
            size: CustomSizes.icon_size_4,
          ),
        ),
      ],
    );
  }

  Expanded buildHedaerDeatils(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.controller.cartList[widget.index].prodactName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: CustomColors.black,
                ),
          ),
          Text(
            widget.controller.cartList[widget.index].prodactDesc,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: CustomColors.grey,
                ),
          ),
        ],
      ),
    );
  }

  Container buildLetterIcon(BuildContext context) {
    return Container(
      width: CustomSizes.icon_size_12,
      height: CustomSizes.icon_size_12,
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.blue, width: 1),
        borderRadius: BorderRadius.circular(CustomSizes.radius_6),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          child: buildCacheNetworkImage(
              url: widget.controller.cartList[widget.index].image, height: 90),
        ),
      ),
    );
  }
}
