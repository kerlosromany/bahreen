class NotificationObject {
  final int id;
  final String content;
  final String createdAt;
  bool isSeen;
  final String? image;
  final int? store;

  NotificationObject({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isSeen,
    this.image,
    this.store,
  });
}
