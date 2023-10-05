import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/app/modules/home/data/models/product_model.dart';
import 'package:b2b_ecommerce/constant/reusable_widget.dart';
import 'package:b2b_ecommerce/constant/shimmer_loading.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/mutation/product_pagination_mutation.dart';

class ProductsController extends GetxController {
  final count = 0.obs;

  final shimmerLoading = ShimmerLoading();
  final reusableWidget = ReusableWidget();

  var loading = false.obs;
  var loadingProdact = false.obs;
  final countProdact = 0.obs;
  var prodactData = <ProdactModel>[].obs;

  final PagingController<int, ProdactModel> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(
      (pageKey) {
        fetchAlldata(pageKey);
      },
    );
  }

  fetchAlldata(int pageKey) {
    getProdacByPagination(pageKey);
  }

  Future<void> getProdacByPagination(int pageKey) async {
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    ProdactPaginationyMutation prodactQueryMutation =
        ProdactPaginationyMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    QueryResult result = await _client.query(
      QueryOptions(
        document:
            gql(prodactQueryMutation.getMyProdact(int.parse("10"), pageKey)),
      ),
    );

    if (!result.hasException) {
      prodactData.clear();
      loadingProdact(true);

      for (var i = 0; i < result.data!["products"]["data"].length; i++) {
        prodactData.add(ProdactModel(
          id: result.data!["products"]["data"][i]["id"],
          name: result.data!["products"]["data"][i]["name"],
          iamgelink: result.data!["products"]["data"][i]["images"][0]
              ["original_url"],
          description: result.data!["products"]["data"][i]["description"],
        ));
        // for (var j = 0;
        //     j < result.data!["products"]["data"][i]["images"].length;
        //     j++) {

        // }
      }
      final isLastPage = prodactData.length < 20;
      countProdact.value = prodactData.length;
      if (isLastPage) {
        pagingController.appendLastPage(prodactData);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(
          prodactData.value,
          nextPageKey,
        );
      }
    } else {
      loadingProdact(false);
      print("object");
      print(result.exception);
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
