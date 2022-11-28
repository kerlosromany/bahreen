abstract class StoreState {}

class StoresInitialState extends StoreState {}

class LoadingGetStoresState extends StoreState {}

class SuccessGetStoresState extends StoreState {}
class EmptyStoresState extends StoreState {}

class ErrorGetStoresState extends StoreState {
  final String error;

  ErrorGetStoresState(this.error);
}
