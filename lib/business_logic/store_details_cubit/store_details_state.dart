abstract class StoreDetailsState {}

class StoreDetailsInitialState extends StoreDetailsState {}

class LoadingStoreDetailsState extends StoreDetailsState {}

class SuccessStoreDetailsState extends StoreDetailsState {}

class ErrorStoreDetailsState extends StoreDetailsState {
  final String error;

  ErrorStoreDetailsState(this.error);
}
