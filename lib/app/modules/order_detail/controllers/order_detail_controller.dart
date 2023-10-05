import 'package:b2b_ecommerce/app/modules/order_detail/data/model/order_detail_model.dart';
import 'package:get/get.dart';

import '../../../../Services/graphql_conf.dart';
import '../../../../constant/reusable_widget.dart';

class OrderDetailController extends GetxController {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  final reusableWidget = ReusableWidget();
  final count = 0.obs;
  List<OrderDetailModel> orderDetail = [];

  var loadingOrderDeatil = false.obs;
  var loadingShipmentDeatil = false.obs;

  // void getData() async {
  //   GraphQLClient _client = graphQLConfiguration.clientToQuery();

  //   QueryResult result = await _client.mutate(
  //     MutationOptions(
  //       document: gql(GetOrderDetailQueryMutation.getMyOrdersDeatil),
  //       variables: <String, dynamic>{
  //         'id': int.parse(Get.arguments['ItemId'].toString()),
  //       },
  //     ),
  //   );

  //   if (!result.hasException) {
  //     for (var i = 0; i < result.data!["order"]["items"].length; i++) {

  //       orderDetail.add(OrderDetailModel(
  //           iid: result.data!["order"]["items"][i]["id"],
  //           quantity: result.data!["order"]["items"][i]["quantity"],
  //           price: result.data!["order"]["items"][i]["product_sku"]["price"],
  //           pname: result.data!["order"]["items"][i]["product_sku"]["product"]
  //               ["name"],
  //           pimage: result.data!["order"]["items"][i]["product_sku"]["product"]
  //               ["images"][0]["original_url"],
  //           shipModel: shipModels));
  //     }
  //     print("orderDetail[i].shipModel.length");
  //     print(orderDetail[0].shipModel.length);
  //     loadingOrderDeatil(true);
  //   } else {
  //     print("amhere");
  //     print(result.exception);
  //     loadingOrderDeatil(false);
  //   }
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
