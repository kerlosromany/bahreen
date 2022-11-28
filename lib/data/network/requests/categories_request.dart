class CategoriesRequest {
  final String? deviceId;
  final String language;

  CategoriesRequest({
    this.deviceId,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId ?? '',
        'language': language,
      };
}
