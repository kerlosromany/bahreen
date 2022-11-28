class ContactRequest {
  final String? deviceId;
  final String? name;
  final String? phone;
  final String message;
  final String language;

  ContactRequest({
    this.deviceId,
    this.name,
    this.phone,
    required this.message,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId ?? '',
        'name': name ?? '',
        'phone': phone ?? '',
        'message': message,
        'language': language,
      };
}
