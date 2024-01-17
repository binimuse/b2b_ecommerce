// ignore_for_file: non_constant_identifier_names

import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/config/theme/custom_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    App(),
  );
}

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
Sizer App() {
  return Sizer(builder:
      (BuildContext context, Orientation orientation, DeviceType deviceType) {
    return GraphQLProvider(
        client: graphQLConfiguration.client,
        child: CacheProvider(
          child: GetMaterialApp(
            title: "ANT B2B",
            // initialBinding: NetworkBinding(),
            theme: CustomTheme().lightTheme,

            ///to take system theme
            themeMode: ThemeMode.light,
            initialRoute: AppPages.INITIAL,
            debugShowCheckedModeBanner: false,
            getPages: AppPages.routes,
          ),
        ));
  });
}
