import 'package:elbahreen/data/models/store_object.dart';

class StoresDetailsResponse {
  final int status;
  final StoreObject storeDetails;

  StoresDetailsResponse({
    required this.status,
    required this.storeDetails,
  });

  StoresDetailsResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        storeDetails = json['storeDetails'];
}
