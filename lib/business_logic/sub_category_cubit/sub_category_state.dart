abstract class SubCategoryState {}

class CategoriesInitialState extends SubCategoryState {}

class LoadingGetSubCategoriesState extends SubCategoryState {}

class SuccessGetSubCategoriesState extends SubCategoryState {}

class EmptySubCategoriesState extends SubCategoryState {}

class ErrorGetSubCategoriesState extends SubCategoryState {
  final String error;

  ErrorGetSubCategoriesState(this.error);
}
