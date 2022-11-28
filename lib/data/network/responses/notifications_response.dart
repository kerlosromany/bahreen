
class NotificationsResponse {
  final int status;
  final List<dynamic> notifications;

  NotificationsResponse({
    required this.status,
    required this.notifications,
  });

  NotificationsResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        notifications = json['notifications'];
}
