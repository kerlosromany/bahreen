
class DistrictsResponse {
  final int status;
  final List<dynamic> districts;

  DistrictsResponse({
    required this.status,
    required this.districts,
  });

  DistrictsResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        districts = json['districts'];
}
