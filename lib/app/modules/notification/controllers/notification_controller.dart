import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/app/modules/notification/data/model/getnotfication_model.dart';
import 'package:b2b_ecommerce/app/modules/notification/data/mutation/getnotificaoin_mutuation.dart';
import 'package:b2b_ecommerce/constant/reusable_widget.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NotificationController extends GetxController {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  var loadingNotification = false.obs;

  final count = 0.obs;
  final reusableWidget = ReusableWidget();
  var getNotification = <GestNotification>[].obs;
  @override
  void onInit() {
    getNotifications();

    super.onInit();
  }

  void getNotifications() async {
    NotificationMutation notificationMutation = NotificationMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(notificationMutation.getNotification()),
      ),
    );

    if (!result.hasException) {
      loadingNotification(true);
      print("object");
      for (var i = 0; i < result.data!["notifications"].length; i++) {
        getNotification.add(GestNotification(
          id: result.data!["notifications"][i]["id"],
          title: result.data!["notifications"][i]["title"],
          body: result.data!["notifications"][i]["body"],
          seen: result.data!["notifications"][i]["seen"],
          created_at: result.data!["notifications"][i]["created_at"],
        ));
      }
    } else {
      print(result.exception);
      loadingNotification(false);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}


// flutter webview ? 
