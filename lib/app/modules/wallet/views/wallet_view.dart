// ignore_for_file: unnecessary_null_comparison

import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/app/common/widgets/dialog_payment.dart';
import 'package:b2b_ecommerce/app/modules/wallet/data/model/depositedata_model.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:b2b_ecommerce/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: PagesUtil.getAppBarLightStyle(),
        leading: Padding(
          padding: EdgeInsets.all(CustomSizes.mp_w_2),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(CustomSizes.radius_6),
            child: CustomButtonFeedBack(
              onTap: () {
                Get.back();
                KeyboardUtil.hideKeyboard(context);
              },
              child: Icon(
                FontAwesomeIcons.chevronLeft,
                color: CustomColors.blue,
                size: CustomSizes.icon_size_4,
              ),
            ),
          ),
        ),
        title: Text(
          'Wallet Top Up',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${controller.walletamount.value} ETB",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: CustomColors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "Available Balance",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: CustomColors.grey),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: CustomColors.lightGrey.withOpacity(0.7),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.attach_money,
                              color: CustomColors.blue,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Credit",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: CustomColors.grey),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          const DialogPayment(),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: CustomColors.lightGrey.withOpacity(0.7),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.trending_up,
                              color: CustomColors.blue,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Topup",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: CustomColors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Recent Deposit",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: CustomColors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        controller: ScrollController(keepScrollOffset: false),
                        padding: EdgeInsets.symmetric(
                            horizontal: CustomSizes.mp_w_4),
                        itemBuilder: (BuildContext context, int index) {
                          return _buildOrderHistoryCard(
                              controller.deposietData[index], context);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: CustomSizes.mp_w_4,
                          );
                        },
                        itemCount: controller.deposietData.length,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1,
          )
        ],
      ),
    );
  }

  Widget _buildOrderHistoryCard(
      DeposteModel deposteModel, BuildContext context) {
    return Obx(() => controller.loadingappdata.value != false
        ? const CircularProgressIndicator()
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(18))),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.date_range, color: CustomColors.blue),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      deposteModel.confirmed_at == null
                          ? Text(
                              "Payment Pending",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: CustomColors.red),
                            )
                          : Text(
                              "Payment accepted",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: CustomColors.black),
                            ),
                      Text(
                        "Payment from user",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: CustomColors.grey),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    deposteModel.confirmed_at == null
                        ? Text(
                            "${deposteModel.amount} ETB",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: CustomColors.red),
                          )
                        : Text(
                            "${deposteModel.amount} ETB",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: CustomColors.green),
                          ),
                    Text(
                      "26 Jan",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: CustomColors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ));
  }
}
