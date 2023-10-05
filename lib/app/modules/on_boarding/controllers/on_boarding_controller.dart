import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  ///PAGE VIEW CONTROLLER INIT
  late PageController tController;

  final currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void setPageViewPage(int page) {
    currentPage(page);
  }

  void goToNextPage() {
    int n = currentPage.value;

    if (currentPage.value < 2) {
      n = currentPage.value + 1;
    }

    tController.jumpToPage(n);
    // tController.animateToPage(
    //   n,
    //   duration: const Duration(microseconds: 500),
    //   curve: Curves.easeIn,
    // );
  }
}
