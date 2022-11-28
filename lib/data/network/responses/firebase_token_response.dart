class FirebaseTokenResponse {
  final int status;

  FirebaseTokenResponse({required this.status});

  FirebaseTokenResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'];
}
