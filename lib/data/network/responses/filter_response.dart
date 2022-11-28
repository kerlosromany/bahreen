
class FilterResponse {
  final int status;
  final List<dynamic> stores;

  FilterResponse({
    required this.status,
    required this.stores,
  });

  FilterResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        stores = json['stores'];
}
