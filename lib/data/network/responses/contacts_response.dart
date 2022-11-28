import 'package:elbahreen/data/models/cantacts_model.dart';

class ContactsResponse{
  final int status;
  final ContactsModel contactsModel;

  ContactsResponse({
    required this.contactsModel,
    required this.status,
});
  factory ContactsResponse.fromJson(Map<String, dynamic> json) => ContactsResponse(
    status: json["status"] ?? 400,
    contactsModel: json["contacts"] != null
        ? ContactsModel.fromJson(json["contacts"])
        : json["contacts"],

  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "contacts": contactsModel.toJson(),
  };

}