class NotificationsRequest {
  final String deviceId;
  final String language;
  final int page;

  NotificationsRequest({
    required this.deviceId,
    required this.language,
    required this.page,
  });

  Map<String, dynamic> toJson() => {
    'deviceId': deviceId,
    'language': language,
    'page': page,
  };
}
