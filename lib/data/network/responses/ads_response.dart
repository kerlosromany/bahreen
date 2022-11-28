
class AdsResponse {
  final int status;
  final List<dynamic> ads;

  AdsResponse({
    required this.status,
    required this.ads,
  });

  AdsResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        ads = json['ads'];
}
