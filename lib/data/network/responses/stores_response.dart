
class StoresResponse {
  final int status;
  final List<dynamic> stores;

  StoresResponse({
    required this.status,
    required this.stores,
  });

  StoresResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        stores = json['stores'];
}
