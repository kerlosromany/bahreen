class SearchRequest {
  final String? deviceId;
  final String keyword;
  final int page;
  final String language;

  SearchRequest({
    this.deviceId,
    required this.keyword,
    required this.page,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId ?? '',
        'keyword': keyword,
        'page': page,
        'language': language,
      };
}
