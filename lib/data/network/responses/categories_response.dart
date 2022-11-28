
class CategoriesResponse {
  final int status;
  final List<dynamic> categories;

  CategoriesResponse({
    required this.status,
    required this.categories,
  });

  CategoriesResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        categories = json['categories'];
}
