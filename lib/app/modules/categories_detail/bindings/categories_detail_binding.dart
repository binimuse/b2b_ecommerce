import 'package:get/get.dart';

import '../controllers/categories_detail_controller.dart';

class CategoriesDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesDetailController>(
      () => CategoriesDetailController(),
    );
  }
}
