class AboutUsResponse {
  final int status;
  final dynamic aboutUs;

  AboutUsResponse({
    required this.status,
    required this.aboutUs,
  });

  AboutUsResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        aboutUs = json['aboutUs'];
}
