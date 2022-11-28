abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class LanguageChangedState extends GlobalState {}

class LoadingGetCategoriesState extends GlobalState {}

class SuccessGetCategoriesState extends GlobalState {}

class EmptyCategoriesState extends GlobalState {}

class ErrorGetCategoriesState extends GlobalState {
  final String error;

  ErrorGetCategoriesState(this.error);
}

class LoadingGetAdsState extends GlobalState {}

class SuccessGetAdsState extends GlobalState {}

class ErrorGetAdsState extends GlobalState {
  final String error;

  ErrorGetAdsState(this.error);
}

class LoadingGetUnSeenState extends GlobalState {}

class SuccessGetUnSeenState extends GlobalState {}

class ErrorGetUnSeenState extends GlobalState {
  final String error;

  ErrorGetUnSeenState(this.error);
}

class SearchLoadingState extends GlobalState {}

class SearchSuccessState extends GlobalState {}

class SearchEmptyState extends GlobalState {}

class SearchErrorState extends GlobalState {
  final String error;

  SearchErrorState(this.error);
}

// join trader states

class RemoveFromListState extends GlobalState {}

class AddToListState extends GlobalState {}


class ChangePhotoState extends GlobalState {}

