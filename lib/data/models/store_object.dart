import 'branch_object.dart';

class StoreObject {
  final int id;
  final int subCategoryId;
  final String name;
  final String? image;
  final List<BranchObject>? branches;

  StoreObject({
    required this.id,
    required this.subCategoryId,
    required this.name,
    this.image,
    this.branches,
  });
}
