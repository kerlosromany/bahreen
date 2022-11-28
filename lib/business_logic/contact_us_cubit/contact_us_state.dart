abstract class ContactUsState {}

class ContactUsInitialState extends ContactUsState {}

class LoadingGetContactUsState extends ContactUsState {}

class SuccessGetContactUsState extends ContactUsState {}

class ErrorGetContactUsState extends ContactUsState {
  final String error;

  ErrorGetContactUsState(this.error);
}

class ContactUsLoading extends ContactUsState {}
class ContactUsSuccess extends ContactUsState {}
class ContactUsFail extends ContactUsState {}