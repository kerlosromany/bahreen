class SearchResponse {
  final int status;
  final dynamic data;

  SearchResponse({
    required this.status,
    required this.data,
  });

  SearchResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = json['data'];
}
