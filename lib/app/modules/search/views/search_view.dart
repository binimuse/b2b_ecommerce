import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/constant/global_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchControllers> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: GlobalStyle.appBarIconThemeColor,
            ),
            systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
            centerTitle: true,
            titleSpacing: 0.0,
            backgroundColor: GlobalStyle.appBarBackgroundColor,
            elevation: 1,
            // create search text field in the app bar
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                height: kToolbarHeight - 16,
                child: TextFormField(
                  controller: controller.etSearch,
                  textInputAction: TextInputAction.search,
                  onChanged: (textValue) {
                    controller.loadData(false);
                    controller.searchKey = textValue;
                    controller.getRestaurantData();
                  },
                  onTap: () {
                    controller.loadData(false);
                  },
                  onFieldSubmitted: (textValue) {
                    if (textValue != '') {
                      controller.searchKey = textValue;
                      controller.getRestaurantData();
                      controller.saveHistory();
                    }
                  },
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: const Color(0xff757A80),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 5.w,
                      color: Colors.black45,
                    ),
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(
                        color: CustomColors.blue.withOpacity(0.4),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                      borderSide: BorderSide(
                        color: CustomColors.blue,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 4.w,
                      horizontal: 2.w,
                    ),
                  ),
                ),
              ),
            )),
        body: Obx(() => WillPopScope(
              onWillPop: () {
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
                return Future.value(true);
              },
              // if search field is empty, show history search
              // if search field not empty, show search text
              child: controller.noResult.value
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://cdni.iconscout.com/illustration/premium/thumb/sorry-item-not-found-3328225-2809510.png',
                          ),
                          const Text(
                            "No Result Found!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.blueAccent),
                          )
                        ],
                      ),
                    )
                  : controller.loadData.value == true
                      ? _loadNewData()
                      : _showSearchText(context),
            )));
  }

  Widget _loadNewData() {
    return (controller.loading.value == true)
        ? controller.shimmerLoading.buildShimmerContent()
        : ListView.builder(
            itemCount: controller.prodactData.length,
            padding: const EdgeInsets.symmetric(vertical: 0),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return controller.reusableWidget.buildPharmacyList(
                  context, index, controller.prodactData, controller);
            },
          );
  }




  Widget _showSearchText(context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            FocusScope.of(context).unfocus();

            controller.getRestaurantData();
          },
          child: Row(
            children: [
              const SizedBox(width: 12),
              Text(controller.etSearch.text,
                  style:
                      const TextStyle(color: CustomColors.blue, fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }
}
