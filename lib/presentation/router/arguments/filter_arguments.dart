class FilterArguments {
  final int categoryId;
  final String? categoryTitle;
  final int? subCategoryId;
  final int? districtId;
  final String? subCategory;
  final bool isNotEmpty;

  FilterArguments(
    this.categoryId, {
    this.isNotEmpty = true,
    this.districtId,
    this.subCategoryId,
    this.subCategory,
    this.categoryTitle,
  });
}
