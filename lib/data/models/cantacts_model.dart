class ContactsModel{
  final int id;
  final List<dynamic> phones;
  final List<dynamic> emails;

  ContactsModel({
    required this.id,
    required this.emails,
    required this.phones,
});

  factory ContactsModel.fromJson(Map<String, dynamic> json) => ContactsModel(
    id: json["id"] ?? 0,
    emails: json["emails"] ?? "",
    phones: json["phones"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emails":emails,
    "phones":phones,
  };

}