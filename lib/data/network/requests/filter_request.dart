class FilterRequest {
  final String? deviceId;
  final int? subCategoryId;
  final int? districtId;
  final String language;

  FilterRequest({
    this.deviceId,
    this.subCategoryId,
    this.districtId,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId ?? '',
        'subCategoryId': subCategoryId ?? 0,
        'districtId': districtId ?? 0,
        'language': language,
      };
}
