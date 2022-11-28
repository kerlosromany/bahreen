class UnSeenNotificationsResponse {
  final int status;
  final int count;

  UnSeenNotificationsResponse({
    required this.status,
    required this.count,
  });

  UnSeenNotificationsResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        count = json['count'];
}
