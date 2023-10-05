import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {

  var acc;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void checkIfLogin() async {
    final prefs = await SharedPreferences.getInstance();

    acc = prefs.getString('access_token');

    if (acc != null) {
      Get.toNamed(Routes.MAIN_PAGE);
    } else {
      Get.toNamed(Routes.SIGN_IN);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
