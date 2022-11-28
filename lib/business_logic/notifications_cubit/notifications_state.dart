abstract class NotificationsState {}

class NotificationsInitialState extends NotificationsState {}

class LoadingGetNotificationsState extends NotificationsState {}

class SuccessGetNotificationsState extends NotificationsState {}

class ErrorGetNotificationsState extends NotificationsState {
  final String error;

  ErrorGetNotificationsState(this.error);
}
