class BranchObject {
  final int id;
  final String name;
  final String address;
  final String? phone;
  final String? whatsappLink;
  final String? instaLink;

  BranchObject({
    required this.id,
    required this.name,
    required this.address,
    this.phone,
    this.whatsappLink,
    this.instaLink,
  });
}
