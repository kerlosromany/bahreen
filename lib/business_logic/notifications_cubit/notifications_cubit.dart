import 'package:dio/dio.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../constants/end_points.dart';
import '../../data/network/responses/notifications_response.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitialState());

  static NotificationsCubit get(context) => BlocProvider.of(context);
  NotificationsResponse? notificationsResponse;

  getNotifications() async {
    emit(LoadingGetNotificationsState());
    try {
      Response response = await DioHelper.getData(
        url: epNotifications,
        query: {
          "deviceId":CacheHelper.getDataFromSharedPreference(key: "deviceId"),
          "language":CacheHelper.getDataFromSharedPreference(key: 'language'),
        },
      );
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorGetNotificationsState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      notificationsResponse =
          NotificationsResponse.fromJson(response.data);
      emit(SuccessGetNotificationsState());
    } on DioError catch (exception) {
      emit(ErrorGetNotificationsState(exception.toString()));
    }
  }
}
