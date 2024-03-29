// ignore_for_file: invalid_use_of_protected_member, unrelated_type_equality_checks

import 'package:b2b_ecommerce/config/theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/theme/custom_colors.dart';
import '../../../../config/theme/custom_sizes.dart';
import '../../../../config/utils/pages_util.dart';
import '../../../../constant/constants.dart';

import '../../../common/widgets/custom_normal_button.dart';
import '../../../common/widgets/form_error.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: PagesUtil.getAppBarLightStyle(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///ACT HEADER
              buildActHeader(context),

              ///BUILD DECORATIVE IMAGE
              buildImage(),

              ///BUILD SIGN IN INPUTS
              buildSignInInputs(context),

              ///BUILD SIGN IN BUTTON
              buildSignInButton(context),

              SizedBox(
                height: CustomSizes.mp_v_6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image buildImage() {
    return Image.asset(
      AppAssets.anniversary,
      width: double.infinity,
      height: 25.h,
      fit: BoxFit.contain,
    );
  }

  Text buildActHeader(BuildContext context) {
    return Text(
      "ANT",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(color: CustomColors.blue, fontWeight: FontWeight.w600),
    );
  }

  buildSignInInputs(context) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: controller.regFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_6),
        child: Column(
          children: [
            Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CustomColors.blue, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: CustomSizes.mp_v_4,
            ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              controller: controller.nameController,
              keyboardType: TextInputType.name,
              onSaved: (newValue) => controller.name.value = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.removeError(error: kNameNullError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  controller.addError(error: kNameNullError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "Enter your Name",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(
                  FontAwesomeIcons.solidUser,
                  color: CustomColors.grey,
                  size: CustomSizes.icon_size_4,
                ),
              ),
            ),
            SizedBox(
              height: CustomSizes.mp_v_4 / 2,
            ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
              onSaved: (newValue) => controller.email.value = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.removeError(error: kEmailNullError);
                } else if (emailValidatorRegExp.hasMatch(value)) {
                  controller.removeError(error: kInvalidEmailError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  controller.addError(error: kEmailNullError);
                  return "";
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  controller.addError(error: kInvalidEmailError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(
                  FontAwesomeIcons.solidMailbox,
                  color: CustomColors.grey,
                  size: CustomSizes.icon_size_4,
                ),
              ),
            ),
            SizedBox(
              height: CustomSizes.mp_v_4 / 2,
            ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              controller: controller.passwordController,
              obscureText: true,
              onSaved: (newValue) => controller.password.value = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.removeError(error: kPassNullError);
                } else if (value.length >= 8) {
                  controller.removeError(error: kShortPassError);
                }
                controller.password.value = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  controller.addError(error: kPassNullError);
                  return "";
                } else if (value.length < 8) {
                  controller.addError(error: kShortPassError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(
                  FontAwesomeIcons.solidKey,
                  color: CustomColors.grey,
                  size: CustomSizes.icon_size_4,
                ),
              ),
            ),
            SizedBox(
              height: CustomSizes.mp_v_4 / 2,
            ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.next,
              controller: controller.passwordConfirmController,
              obscureText: true,
              onSaved: (newValue) =>
                  controller.passwordConfirm.value = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.removeError(error: kPassNullError);
                } else if (value.isNotEmpty &&
                    controller.password == controller.passwordConfirm) {
                  controller.removeError(error: kMatchPassError);
                }
                controller.passwordConfirm.value = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  controller.addError(error: kPassNullError);
                  return "";
                } else if ((controller.password != value)) {
                  controller.addError(error: kMatchPassError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Confirm Password",
                hintText: "Re-enter your password",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(
                  FontAwesomeIcons.solidKey,
                  color: CustomColors.grey,
                  size: CustomSizes.icon_size_4,
                ),
              ),
            ),
            SizedBox(
              height: CustomSizes.mp_v_4 / 2,
            ),
            Obx(() => controller.loading.value != true
                ? const Center(child: CircularProgressIndicator())
                : FormError(errors: controller.errors.value)),
          ],
        ),
      ),
    );
  }

  buildSignInButton(context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: CustomSizes.mp_w_6,
            right: CustomSizes.mp_w_6,
            top: CustomSizes.mp_w_10,
            bottom: CustomSizes.mp_w_6,
          ),
          child: CustomNormalButton(
            text: "Sign Up",
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CustomColors.white,
                ),
            bgColor: CustomColors.blue,
            padding: EdgeInsets.symmetric(
              horizontal: CustomSizes.mp_v_2,
              vertical: CustomSizes.mp_v_2 * 0.8,
            ),
            onPressed: () {
              controller.checkReg();
            },
          ),
        ),
        Text(
          'By continuing your confirm that you agree \nwith our Term and Condition',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: CustomColors.lightBlack,
              fontWeight: FontWeight.w400,
              fontSize: CustomSizes.font_12),
        )
      ],
    );
  }
}
