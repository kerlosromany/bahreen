import 'package:elbahreen/data/models/branch_object.dart';

String generateBranchesText(List<BranchObject> branches) {
  List<String> branchesName = [];
  for (BranchObject branch in branches) {
    branchesName.add(branch.name);
  }

  String text = '';
  for (var branchName in branchesName) {
    text += branchName;
    if (branchesName.indexOf(branchName) != branches.length - 1) {
      text += ' - ';
    }
  }
  return text;
}

Map<String, String> generateNoOfBranchContact(BranchObject branch) {
  Map<String, String> mediaContacts = {};

  if (branch.phone != null) {
    mediaContacts['assets/icons/phone.png'] = branch.phone!;
  }
  if (branch.whatsappLink != null) {
    mediaContacts['assets/icons/whatsapp.png'] = branch.whatsappLink!;
  }
  if (branch.instaLink != null) {
    mediaContacts['assets/icons/instagram.png'] = branch.instaLink!;
  }
  mediaContacts['assets/icons/placeholder.png'] = branch.address;
  return mediaContacts;
}
