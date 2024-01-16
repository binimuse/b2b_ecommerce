import 'dart:async';

import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/app/modules/my_orders/data/model/order_model.dart';
import 'package:b2b_ecommerce/app/modules/my_orders/data/model/shipment_model.dart';
import 'package:b2b_ecommerce/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:b2b_ecommerce/constant/reusable_widget.dart';
import 'package:b2b_ecommerce/constant/shimmer_loading.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../data/mutation/order_mutuation.dart';

class MyOrdersController extends GetxController {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  WalletController walletController = Get.put(WalletController());
  final count = 0.obs;
  final shimmerLoading = ShimmerLoading();
  final reusableWidget = ReusableWidget();
  var loadingOrderHistory = false.obs;

  //Detail

  var loadingOrderDeatil = false.obs;
  var loadingShipmentDeatil = false.obs;

  Timer? timerDummy;

  List<OrderHistoryModel> orderData = [];
  List<OrderItemModel> orderItems = [];
  List<ShipModel> shipModels = [];
  @override
  void onInit() {
    getData();
    walletController.gwtwalletammount();
    super.onInit();
  }

  void getData() async {
    GetOrderQueryMutation orderQueryMutation = GetOrderQueryMutation();
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.query(
      QueryOptions(
        document: gql(orderQueryMutation.getMyOrdersHistory()),
      ),
    );

    if (!result.hasException) {
      if (result.data!["auth"]["retailer"] != null) {
        for (var i = 0;
            i < result.data!["auth"]["retailer"]["orders"].length;
            i++) {
          String createdAtHuman =
              result.data!["auth"]["retailer"]["orders"][i]["created_at_human"];
          List<OrderItemModel> items = [];
          List<ShipModel> shipModel = [];
          dynamic total_price =
              result.data!["auth"]["retailer"]["orders"][i]["total_price"];
          dynamic oid = result.data!["auth"]["retailer"]["orders"][i]["id"];

          // orderItems.clear();

          for (var j = 0;
              j < result.data!["auth"]["retailer"]["orders"][i]["items"].length;
              j++) {
            items.add(OrderItemModel(
              quantity: result.data!["auth"]["retailer"]["orders"][i]["items"]
                  [j]["quantity"],
              iid: int.parse(result.data!["auth"]["retailer"]["orders"][i]
                  ["items"][j]["id"]),
              image: result.data!["auth"]["retailer"]["orders"][i]["items"][j]
                  ["product_sku"]["product"]["images"][0]["original_url"],
              name: result.data!["auth"]["retailer"]["orders"][i]["items"][j]
                  ["product_sku"]["product"]["name"],
              price: result.data!["auth"]["retailer"]["orders"][i]["items"][j]
                  ["product_sku"]["price"],
              shipModel: shipModel,
            ));
            if (result
                    .data!["auth"]["retailer"]["orders"][i]["items"][j]
                        ["shipment_items"]
                    .length >
                0) {
              shipModel.add(ShipModel(
                  shipmentID: "",
                  departure_time: result.data!["auth"]["retailer"]["orders"][i]["items"]
                      [j]["shipment_items"][0]["shipment"]["departure_time"],
                  arrival_time: result
                      .data!["auth"]["retailer"]["orders"][i]["items"][j]
                          ["shipment_items"]
                      .last["shipment"]["arrival_time"],
                  status: result.data!["auth"]["retailer"]["orders"][i]["items"][j]["shipment_items"].last["shipment"]
                      ["status"],
                  from: result
                      .data!["auth"]["retailer"]["orders"][i]["items"][j]["shipment_items"]
                      .last["shipment"]["from"]["__typename"],
                  fromname: result.data!["auth"]["retailer"]["orders"][i]["items"][j]["shipment_items"].last["shipment"]["from"]["name"],
                  to: result.data!["auth"]["retailer"]["orders"][i]["items"][j]["shipment_items"].last["shipment"]["to"]["__typename"],
                  toname: result.data!["auth"]["retailer"]["orders"][i]["items"][j]["shipment_items"].last["shipment"]["to"]["name"]));
            }

            // shipModels.clear();

          }

          orderData.add(OrderHistoryModel(
            created_at_human: createdAtHuman,
            items: items,
            total_price: total_price,
            oid: oid,
          ));

          loadingOrderHistory(true);
        }
      }
    } else {
      loadingOrderHistory(false);
    }
  }

  @override
  void dispose() {
    timerDummy?.cancel();
    super.dispose();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
