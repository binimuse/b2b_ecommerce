import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../Services/graphql_conf.dart';
import '../data/updatedropoffmuataion.dart';

class ScanQrCodeController extends GetxController {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  Barcode? result;
  QRViewController? controllers;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var data = "".obs;
  final count = 0.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    controllers?.dispose();
    super.dispose();
  }

  void reassemble() {
    if (Platform.isAndroid) {
      controllers!.pauseCamera();
    }
    controllers!.resumeCamera();
  }

  buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void onQRViewCreated(QRViewController controllerp) {
    controllers = controllerp;

    controllerp.scannedDataStream.listen((scanData) {
      result = scanData;
      data.value = result!.code.toString();
    });

    if (data.isNotEmpty) {
      isLoading(true);
    } else {
      isLoading(false);
    }
  }

  void updateDropoff() async {
    List values = data.value.split(
        ","); // split() will split from . and gives new List with separated elements.
    values.forEach(print);
    var dropOff = values[0].toString();
    var order = values[1].toString();

    // print("haaha ${dropOffID}");
    // print("haaha ${orderId}");

    int? orderId = int.tryParse(order.replaceAll(RegExp(r'[^0-9]'), ''));
    int? dropOffId = int.tryParse(dropOff.replaceAll(RegExp(r'[^0-9]'), ''));

    //print(orderId);
    GraphQLClient client = graphQLConfiguration.clientToQuery();
    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(UpdatedropoffMutation.updateDropoff),
        variables: <String, dynamic>{
          'id': dropOffId,
          "order_received": true,
          "order_recived_id": orderId,
          // 'orders': {'received': true, 'id': orderId},
        },
      ),
    );
    if (!result.hasException) {
      Get.back();
      Get.back();
      data.value = "";
    } else {
      print(result.exception);
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    //log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
