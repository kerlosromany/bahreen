class UnSeenNotificationsRequest {
  final String? deviceId;

  UnSeenNotificationsRequest({this.deviceId});

  Map toJson() => {'deviceId': deviceId ?? ''};
}
