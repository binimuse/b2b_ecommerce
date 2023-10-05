// ignore_for_file: depend_on_referenced_packages

import 'package:b2b_ecommerce/config/theme/custom_button_styles.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/theme/custom_text_styles.dart';
import 'package:b2b_ecommerce/config/utils/screen_utils.dart';
import 'package:flutter/material.dart';

import 'custom_colors.dart';

class CustomTheme {
  // final ThemeData darkTheme = ThemeData.dark().copyWith(
  //   ///COLORS
  //   primaryColor: CustomColors.blue,
  //   backgroundColor: CustomColors.lightBlack,
  //   scaffoldBackgroundColor: CustomColors.lightBlack,
  //   dialogBackgroundColor: CustomColors.white,
  //
  //   ///TEXT STYLES
  //   textTheme: TextTheme(
  //     bodySmall: CustomTextStyles.bodySmall,
  //     bodyMedium: CustomTextStyles.bodyMedium,
  //     bodyLarge: CustomTextStyles.bodyLarge,
  //     headlineSmall: CustomTextStyles.headlineSmall,
  //     headlineMedium: CustomTextStyles.headlineMedium,
  //     headlineLarge: CustomTextStyles.headlineLarge,
  //   ),
  //
  //   ///INPUT DEFAULT STYLE
  //   inputDecorationTheme: InputDecorationTheme(
  //     filled: true,
  //     fillColor: CustomColors.lightWhite,
  //     contentPadding: EdgeInsets.symmetric(
  //       vertical: ScreenUtil().isPhone()
  //           ? CustomSizes.mp_v_2
  //           : CustomSizes.mp_v_4 * 0.7,
  //       horizontal: CustomSizes.mp_v_2,
  //     ),
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(CustomSizes.radius_6),
  //       borderSide: BorderSide.none,
  //     ),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(CustomSizes.radius_6),
  //       borderSide: BorderSide.none,
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(CustomSizes.radius_6),
  //       borderSide: const BorderSide(
  //         color: CustomColors.lightGrey,
  //         width: 1.0,
  //       ),
  //     ),
  //     errorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(CustomSizes.radius_6),
  //       borderSide: BorderSide(
  //         color: CustomColors.red.withOpacity(0.7),
  //         width: 1.0,
  //       ),
  //     ),
  //     disabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(CustomSizes.radius_6),
  //       borderSide: BorderSide.none,
  //     ),
  //     hintStyle: CustomTextStyles.bodyMedium.copyWith(
  //       color: CustomColors.grey,
  //       fontWeight: FontWeight.w300,
  //     ),
  //   ),
  //
  //   ///BUTTON STYLES
  //   elevatedButtonTheme: CustomButtonStyles.elevatedButtonThemeData,
  //   textButtonTheme: CustomButtonStyles.textButtonThemeData,
  //
  //   ///RADIO ///CHECK BOXES
  //   colorScheme: ColorScheme.fromSwatch().copyWith(
  //     primary: CustomColors.blue,
  //     secondary: CustomColors.grey,
  //   ),
  // );

  final ThemeData lightTheme = ThemeData.light().copyWith(
    ///COLORS
    primaryColor: CustomColors.blue,
    backgroundColor: CustomColors.lightWhite,
    dividerColor: CustomColors.grey,
    scaffoldBackgroundColor: CustomColors.white,
    dialogBackgroundColor: CustomColors.white,


    ///TEXT STYLES
    textTheme: TextTheme(
      bodySmall: CustomTextStyles.bodySmall,
      bodyMedium: CustomTextStyles.bodyMedium,
      bodyLarge: CustomTextStyles.bodyLarge,
      headlineSmall: CustomTextStyles.headlineSmall,
      headlineMedium: CustomTextStyles.headlineMedium,
      headlineLarge: CustomTextStyles.headlineLarge,
    ),

    ///INPUT DEFAULT STYLE
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CustomColors.lightWhite,
      contentPadding: EdgeInsets.symmetric(
        vertical: ScreenUtil().isPhone()
            ? CustomSizes.mp_v_2
            : CustomSizes.mp_v_4 * 0.7,
        horizontal: CustomSizes.mp_v_2,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CustomSizes.radius_6),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CustomSizes.radius_6),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CustomSizes.radius_6),
        borderSide:  BorderSide(
          color: CustomColors.blue.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CustomSizes.radius_6),
        borderSide: BorderSide(
          color: CustomColors.red.withOpacity(0.7),
          width: 1.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CustomSizes.radius_6),
        borderSide: BorderSide.none,
      ),
      hintStyle: CustomTextStyles.bodySmall.copyWith(
        color: CustomColors.grey,
        fontWeight: FontWeight.w300,
      ),
    ),

    ///BUTTON STYLES
    elevatedButtonTheme: CustomButtonStyles.elevatedButtonThemeData,
    textButtonTheme: CustomButtonStyles.textButtonThemeData,

    ///RADIO ///CHECK BOXES
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: CustomColors.blue,
      secondary: CustomColors.grey,
    ),
  );
}
