class SubCategoriesRequest {
  final String? deviceId;
  final int categoryId;
  final String language;

  SubCategoriesRequest({
    this.deviceId,
    required this.categoryId,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId ?? '',
        'storeId': categoryId,
        'language': language,
      };
}
