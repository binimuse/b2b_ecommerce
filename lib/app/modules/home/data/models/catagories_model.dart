// ignore_for_file: non_constant_identifier_names

class CategoriesModel {
  late String id;
  late String name;
  late String iamgelink;
  late int children_count;
  late String? description;
//  late String children_iamge;

  CategoriesModel({
    required this.name,
    required this.id,
    required this.iamgelink,
    required this.children_count,
    this.description,
    // required this.children_iamge ,
  });
}
