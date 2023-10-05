import 'dart:async';
import 'package:b2b_ecommerce/app/modules/product_detail/views/widgets/item_product_image.dart';
import 'package:b2b_ecommerce/config/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class ImagesSlider extends StatefulWidget {
  const ImagesSlider({
    Key? key,
    required this.scrollDuration,
    required this.imagePaths,
  }) : super(key: key);

  final List<String> imagePaths;
  final Duration scrollDuration;

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  _ImagesSliderState();

  ///NOTIFIER FOR DOTED INDICATOR
  late ValueNotifier<int> pageNotifier;

  ///CONTROLLER FOR PAGE VIEW
  late PageController controller;

  ///TIMER FOR CAROUSEL
  late Timer timer;

  ///PAGER CURRENT PAGE
  int currentPage = 0;

  @override
  void initState() {
    ///PAGE VIEW CONTROLLER INIT
    controller = PageController(
      initialPage: 0,
      viewportFraction: ScreenUtil().isPhone() ? 1.0 : 0.8,
    );

    ///INDICATOR CONTROLLER INIT
    pageNotifier = ValueNotifier<int>(0);

    ///CAROUSEL TIMER INIT
    timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      controller.animateToPage(
        currentPage,
        duration: widget.scrollDuration,
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.imagePaths.length,
      controller: controller,
      onPageChanged: (index) {
        setState(() {
          pageNotifier.value = index;
          currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        return ItemProductImage(
          imageLink: widget.imagePaths[index],
        );
      },
    );
  }
}
