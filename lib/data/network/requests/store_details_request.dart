class StoresDetailsRequest {
  final String? deviceId;
  final int storeId;

  final String language;

  StoresDetailsRequest({
    this.deviceId,
    required this.storeId,
    required this.language,
  });

  Map toJson() => {
        'deviceId': deviceId ?? '',
        'storeId': storeId,
        'language': language,
      };
}
