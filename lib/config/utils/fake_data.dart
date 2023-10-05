import 'package:b2b_ecommerce/app/modules/home/data/models/category.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FakeData {
  static List<Category> fakeCategories = [
    Category(
      iconData: FontAwesomeIcons.solidJug,
      title: "Detergents",
    ),
    Category(
      iconData: FontAwesomeIcons.breadLoaf,
      title: "Flour and Others",
    ),
    Category(
      iconData: FontAwesomeIcons.solidSquarePlus,
      title: "Health accessories",
    ),
    Category(
      iconData: FontAwesomeIcons.solidMicrochip,
      title: "Technology",
    ),
    Category(
      iconData: FontAwesomeIcons.solidMicrochip,
      title: "Food & Beverages",
    ),
    Category(
      iconData: FontAwesomeIcons.solidMicrochip,
      title: "Vehicles",
    ),
  ];
}
