abstract class FilterState {}

class FilterInitialState extends FilterState {}

class ChangeSubCategoryState extends FilterState {}

class ChangeDistrictState extends FilterState {}

class ChangeRadioButtonState extends FilterState {}

class LoadingGetDistrictsState extends FilterState {}

class SuccessGetDistrictsState extends FilterState {}

class ErrorGetDistrictsState extends FilterState {
  final String error;

  ErrorGetDistrictsState(this.error);
}

class LoadingFilterState extends FilterState {}

class SuccessFilterState extends FilterState {}

class EmptyFilterState extends FilterState {}

class ErrorFilterState extends FilterState {
  final String error;

  ErrorFilterState(this.error);
}

class LoadingSubCategoryState extends FilterState {}

class SuccessSubCategoryState extends FilterState {}

class ErrorSubCategoryState extends FilterState {
  final String error;
  ErrorSubCategoryState(this.error);
  
}
