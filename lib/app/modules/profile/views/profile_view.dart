// ignore_for_file: must_be_immutable

import 'package:b2b_ecommerce/app/common/widgets/custom_normal_button.dart';
import 'package:b2b_ecommerce/app/routes/app_pages.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ///HEADER
          buildHeader(context),

          ///ORDER BUTTON
          buildOrderButton(context),

          SizedBox(
            height: CustomSizes.mp_v_6,
          ),

          ///BUILD PROFILE MENUS LIST
          buildMenusList(context),
        ],
      ),
    );
  }

  IntrinsicWidth buildOrderButton(BuildContext context) {
    return IntrinsicWidth(
      child: CustomNormalButton(
        text: "My Orders",
        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: CustomColors.white,
              fontWeight: FontWeight.w600,
            ),
        padding: EdgeInsets.symmetric(
          horizontal: CustomSizes.mp_w_12,
          vertical: CustomSizes.mp_v_4 * 0.7,
        ),
        onPressed: () {
          Get.toNamed(Routes.MY_ORDERS);
        },
      ),
    );
  }

  buildHeader(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: CustomSizes.mp_v_4,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: CustomColors.blue,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 0),
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: CustomSizes.icon_size_12,
            backgroundImage: const NetworkImage(
              "https://image.shutterstock.com/image-photo/profile-picture-smiling-young-african-260nw-1873784920.jpg",
            ),
          ),
        ),
        SizedBox(
          height: CustomSizes.mp_v_2,
        ),
        Text(
          "Amanuel Leyu",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: CustomSizes.mp_v_4,
        ),
      ],
    );
  }

  buildMenusList(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_6),
      child: Column(
        children: [
          buildMnuItem(
            context,
            FontAwesomeIcons.solidList,
            "Edit Details",
            () {
              Get.toNamed(Routes.EDIT_PROFILE);
            },
          ),
          const Divider(
            color: CustomColors.lightGrey,
            height: 1,
          ),
          buildMnuItem(
            context,
            FontAwesomeIcons.solidBell,
            "Notifications",
            () {
              Get.toNamed(Routes.NOTIFICATION);
            },
          ),
          const Divider(
            color: CustomColors.lightGrey,
            height: 1,
          ),
          buildMnuItem(
            context,
            FontAwesomeIcons.solidAddressBook,
            "Contact Us",
            () {},
          ),
          const Divider(
            color: CustomColors.lightGrey,
            height: 1,
          ),
          buildMnuItem(
            context,
            FontAwesomeIcons.solidRightFromBracket,
            "Logout",
            () async {
              Get.dialog(AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text(
                  'Warning, Logging Out',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                content: const Text('Are you sure you want to log out ?',
                    style: TextStyle(fontSize: 13, color: Colors.black)),
                actions: [
                  cancelButton,
                  continueButton,
                ],
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget cancelButton = TextButton(
      onPressed: () {
        // Navigator.pop();
        Get.back();
      },
      child: const Text('No', style: TextStyle(color: CustomColors.blue)));

  Widget continueButton = TextButton(
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();

        final acc = await prefs.remove('access_token');

        if (acc) {
          Get.offAllNamed(Routes.SIGN_IN);
        }
        // Navigator.pop(context);
      },
      child: const Text('Yes', style: TextStyle(color: CustomColors.blue)));

  buildMnuItem(
    context,
    IconData leftIcon,
    String text,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: CustomSizes.mp_v_2),
          child: Row(
            children: [
              Icon(
                leftIcon,
                color: CustomColors.grey,
                size: CustomSizes.icon_size_4,
              ),
              SizedBox(
                width: CustomSizes.mp_w_4,
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Icon(
                FontAwesomeIcons.solidChevronRight,
                color: CustomColors.blue,
                size: CustomSizes.icon_size_4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
