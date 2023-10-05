import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../modules/my_orders/controllers/my_orders_controller.dart';

class DialogItemOrderStatus extends StatefulWidget {
  const DialogItemOrderStatus({Key? key}) : super(key: key);

  @override
  State<DialogItemOrderStatus> createState() => _DialogItemOrderStatusState();
}

MyOrdersController myOrdersController = Get.put(MyOrdersController());

class _DialogItemOrderStatusState extends State<DialogItemOrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 90.w,
        constraints: BoxConstraints(maxHeight: 75.h),
        child: Material(
          borderRadius: BorderRadius.circular(CustomSizes.radius_6),
          elevation: 2,
          color: CustomColors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: CustomSizes.mp_v_4 * 0.7,
                ),

                ///BUILD HEADER
                //     buildHeader(context),

                SizedBox(
                  height: CustomSizes.mp_v_2,
                ),

                ///BUILD TRACKING ITEMS LIST
                //     buildTrackingList(),

                SizedBox(
                  height: CustomSizes.mp_v_2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // buildHeader(context) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(
  //       horizontal: CustomSizes.mp_w_4,
  //       vertical: CustomSizes.mp_v_2,
  //     ),
  //     color: CustomColors.red.withOpacity(0.1),
  //     child: Column(
  //       children: [
  //         Text(
  //           "Order #12345",
  //           style: Theme.of(context)
  //               .textTheme
  //               .bodySmall
  //               ?.copyWith(color: CustomColors.grey),
  //         ),
  //         Text(
  //           "Item Order Status",
  //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //                 color: CustomColors.blue,
  //                 decoration: TextDecoration.underline,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //         ),
  //         SizedBox(
  //           height: CustomSizes.mp_w_4,
  //         ),
  //         Row(
  //           children: [
  //             buildHeaderItem(
  //               context,
  //               FontAwesomeIcons.solidWarehouse,
  //               "Warehouse",
  //             ),
  //             buildHeaderItem(
  //               context,
  //               FontAwesomeIcons.solidTruckContainer,
  //               "Distribute",
  //             ),
  //             buildHeaderItem(
  //               context,
  //               FontAwesomeIcons.solidPerson,
  //               "Retailer",
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

//   buildHeaderItem(context, IconData icon, String title) {
//     return Expanded(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: CustomSizes.icon_size_4,
//             color: CustomColors.black,
//           ),
//           SizedBox(
//             width: CustomSizes.mp_w_2,
//           ),
//           Text(
//             title,
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                   color: CustomColors.grey,
//                   fontSize: CustomSizes.font_8,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }

//   buildTrackingList() {
//     return Obx(() => myOrdersController.loadingOrderDeatil.value != true
//         ? const Center(child: CircularProgressIndicator())
//         : const ItemOrderTrack());
//   }
// }

// class ItemOrderTrack extends StatelessWidget {
//   const ItemOrderTrack({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Material(
//         elevation: 4,
//         color: CustomColors.white,
//         borderRadius: BorderRadius.circular(
//           CustomSizes.radius_10,
//         ),
//         shadowColor: CustomColors.black.withOpacity(0.4),
//         child: Padding(
//           padding: EdgeInsets.only(
//             left: CustomSizes.mp_w_4,
//             top: CustomSizes.mp_w_4,
//             right: CustomSizes.mp_w_4,
//             bottom: CustomSizes.mp_w_4,
//           ),
//           child: Column(
//             children: [
//               ///HEADER
//               Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(CustomSizes.radius_6),
//                     child: Image.network(
//                       myOrdersController.orderDetail.first.pimage,
//                       width: CustomSizes.mp_w_14,
//                       height: CustomSizes.mp_w_14,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(
//                     width: CustomSizes.mp_w_4,
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           myOrdersController.orderDetail.first.pname,
//                           style:
//                               Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: CustomSizes.font_10,
//                                     color: CustomColors.lightBlack,
//                                   ),
//                         ),
//                         Text(
//                           "${myOrdersController.orderDetail.first.quantity} variants",
//                           style:
//                               Theme.of(context).textTheme.bodySmall?.copyWith(
//                                     fontWeight: FontWeight.w500,
//                                     color: CustomColors.grey,
//                                   ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     "${myOrdersController.orderDetail.first.price} Birr",
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: CustomColors.green,
//                         ),
//                   ),
//                 ],
//               ),

//               SizedBox(
//                 height: CustomSizes.mp_v_2,
//               ),

//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   ListView.separated(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: myOrdersController.shipModels.length,
//                     padding: EdgeInsets.zero,
//                     itemBuilder: (context, index) {
//                       return buildDetailsRow(
//                         context,
//                         myOrdersController.shipModels[index],
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: CustomSizes.mp_v_1,
//                         ),
//                         child: const Divider(
//                           height: 1,
//                           color: CustomColors.grey,
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(
//                     height: CustomSizes.mp_v_4,
//                   ),
//                   Row(
//                     children: [
//                       buildTrackIcon(
//                         FontAwesomeIcons.solidWarehouse,
//                         CustomColors.yellow,
//                       ),
//                       const Expanded(
//                         child: Center(
//                           child: Divider(
//                             color: CustomColors.grey,
//                           ),
//                         ),
//                       ),
//                       buildTrackIcon(
//                         FontAwesomeIcons.solidTruckContainer,
//                         CustomColors.blue,
//                       ),
//                       const Expanded(
//                         child: Center(
//                           child: Divider(
//                             color: CustomColors.grey,
//                           ),
//                         ),
//                       ),
//                       buildTrackIcon(
//                         FontAwesomeIcons.solidUser,
//                         CustomColors.green,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Material buildTrackIcon(IconData icon, Color color) {
//     return Material(
//       borderRadius: BorderRadius.circular(
//         CustomSizes.radius_6,
//       ),
//       color: color.withOpacity(0.2),
//       child: SizedBox(
//         width: CustomSizes.icon_size_12,
//         height: CustomSizes.icon_size_12,
//         child: Center(
//           child: Icon(
//             icon,
//             size: CustomSizes.icon_size_4,
//             color: color,
//           ),
//         ),
//       ),
//     );
//   }

//   buildDetailsRow(
//     BuildContext context,
//     ShipModel shipModel,
//   ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           "Shipment Information",
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: CustomColors.grey,
//                 fontWeight: FontWeight.w400,
//                 fontSize: CustomSizes.font_8,
//               ),
//         ),
//         Text(
//           "",
//           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: CustomColors.grey,
//                 fontSize: CustomSizes.font_10,
//               ),
//         ),
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 24,
//                       height: 24,
//                       child: Center(
//                         child: Icon(
//                           Icons.lock_clock,
//                           size: 24,
//                           color: CustomColors.white,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Departure Time :- ${shipModel.departure_time}',
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                             fontWeight: FontWeight.w500,
//                             color: CustomColors.grey,
//                             fontSize: CustomSizes.font_10,
//                           ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 24,
//                       height: 24,
//                       child: Center(
//                         child: Icon(
//                           Icons.lock_clock,
//                           size: 24,
//                           color: CustomColors.white,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Arrival_time :- ${shipModel.arrival_time}',
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                             fontWeight: FontWeight.w500,
//                             color: CustomColors.grey,
//                             fontSize: CustomSizes.font_10,
//                           ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Container(
//                       width: 24,
//                       height: 24,
//                       decoration: const BoxDecoration(
//                           shape: BoxShape.circle, color: CustomColors.blue),
//                       child: const Center(
//                           child: Icon(Icons.pending,
//                               size: 12, color: Colors.white)),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Status :- ${shipModel.status}',
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                             fontWeight: FontWeight.w500,
//                             color: CustomColors.grey,
//                             fontSize: CustomSizes.font_10,
//                           ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 2),
//                 Row(
//                   children: [
//                     Container(
//                       width: 24,
//                       height: 24,
//                       decoration: const BoxDecoration(
//                           shape: BoxShape.circle, color: CustomColors.blue),
//                       child: const Center(
//                         child:
//                             Icon(Icons.pending, size: 12, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Flexible(
//                       child: Text(
//                         'from :- ' + shipModel.from,
//                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                               fontWeight: FontWeight.w500,
//                               color: CustomColors.grey,
//                               fontSize: CustomSizes.font_10,
//                             ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 2),
//                 Row(
//                   children: [
//                     Container(
//                       width: 24,
//                       height: 24,
//                       decoration: const BoxDecoration(
//                           shape: BoxShape.circle, color: CustomColors.blue),
//                       child: const Center(
//                           child: Icon(Icons.pending,
//                               size: 12, color: Colors.white)),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'to :- ' + shipModel.to,
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                             fontWeight: FontWeight.w500,
//                             color: CustomColors.grey,
//                             fontSize: CustomSizes.font_10,
//                           ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 2),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
// }
}
