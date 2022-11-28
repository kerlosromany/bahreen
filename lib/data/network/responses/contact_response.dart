class ContactResponse {
  final int status;

  ContactResponse({required this.status});

  ContactResponse.fromJson(Map<String, dynamic> json) : status = json['status'];
}
