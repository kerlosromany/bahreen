class StoresRequest {
  final String? deviceId;
  final int subCategoryId  ;
  final String language;

  StoresRequest({
    this.deviceId,
    required this.subCategoryId,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId ?? '',
        'storeId': subCategoryId,
        'language': language,
      };
}
