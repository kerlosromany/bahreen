class FirebaseTokenRequest {
  final String deviceId;
  final String firebaseToken;

  FirebaseTokenRequest({
    required this.deviceId,
    required this.firebaseToken,
  });

  Map toJson() => {
        'deviceId': deviceId,
        'firebaseToken': firebaseToken,
      };
}
