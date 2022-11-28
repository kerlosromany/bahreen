class AboutUsRequest {
  final String language;

  AboutUsRequest({required this.language});

  Map<String, dynamic> toJson() => {'language': language};
}
