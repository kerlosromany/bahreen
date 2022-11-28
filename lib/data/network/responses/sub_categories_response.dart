
class SubCategoriesResponse {
  final int status;
  final List<dynamic> subCategories;

  SubCategoriesResponse({
    required this.status,
    required this.subCategories,
  });

  SubCategoriesResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        subCategories = json['subCategories'];
}
