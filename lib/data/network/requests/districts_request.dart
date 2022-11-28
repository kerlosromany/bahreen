class DistrictsRequest {
  final String? deviceId;
  final String language;

  DistrictsRequest({
    this.deviceId,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId ?? '',
        'language': language,
      };
}
