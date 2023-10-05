import 'dart:async';

import 'package:b2b_ecommerce/app/modules/home/data/models/product_model.dart';
import 'package:b2b_ecommerce/app/modules/search/data/mutaion/search_mutation.dart';
import 'package:b2b_ecommerce/constant/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Services/graphql_conf.dart';
import '../../../../constant/shimmer_loading.dart';
import '../data/model/last_search_model.dart';

class SearchController extends GetxController {
  var shimmerLoading = ShimmerLoading();
  var reusableWidget = ReusableWidget();

  var loading = false.obs;
  var loadData = false.obs;
  var noResult = false.obs;

  var scannedQrValue = '';

  Timer? timerDummy;

  late RxList searchData = <LastSearchModel>[].obs;

  var prodactData = <ProdactModel>[].obs;
  var searchKey = "";
  TextEditingController etSearch = TextEditingController();

  Location location = Location();
  late LocationData locationData;

  var isInitialized = false.obs;

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timerDummy?.cancel();
    etSearch.dispose();
  }

  Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('lastSearch', <String>[etSearch.text.toString()]);
  }

  void getRestaurantData() async {
 
    prodactData.clear();

    if (searchKey.isNotEmpty) {
      loading(true);
      loadData(true);

      SearchQueryMutation searchQueryMutation = SearchQueryMutation();
      GraphQLClient _client = graphQLConfiguration.clientToQuery();

      QueryResult result = await _client.query(
        QueryOptions(
          document: gql(searchQueryMutation.getMysearch(searchKey)),
        ),
      );

      if (!result.hasException) {
     
        // print(result.data!["action"]);
        if (result.data?["searchProduct"].length != 0) {
          noResult(false);

          for (var i = 0; i < result.data!["searchProduct"].length; i++) {
            for (var j = 0;
                j <
                    result.data!["searchProduct"][i]["category"]["products"]
                        .length;
                j++) {
              prodactData.add(ProdactModel(
                id: result.data!["searchProduct"][i]["category"]["products"][j]
                    ["id"],
                name: result.data!["searchProduct"][i]["category"]["products"]
                    [j]["name"],
                iamgelink: result.data!["searchProduct"][i]["category"]
                    ["products"][j]["images"][0]["original_url"],
                description: result.data!["searchProduct"][i]["category"]
                    ["products"][j]["description"],
              ));
            }
          }
          loading(false);
          loadData(true);
        } else {
          print("ghgh noResult");
          print(result.exception);
          noResult(true);
        }
      } else {
        print("ghgh exception");
        print(result.exception);
        noResult(true);
      }
    }
    // timerDummy = Timer(const Duration(seconds: 2), () {
    //   loading(false);
    // });
  }

  // startScan() async {
  //   List<OcrText> list = [];
  //   try {
  //     list = await FlutterMobileVision.read(
  //         waitTap: true, fps: 5, multiple: false);

  //     for (OcrText text in list) {
  //       etSearch.text = text.value.toString();
  //     }
  //   } catch (e) {}
  // }

  // startQrScan() async {
  //   Get.snackbar('title', 'message');
  // }
}
