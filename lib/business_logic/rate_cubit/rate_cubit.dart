
import 'package:dio/dio.dart';
import 'package:elbahreen/business_logic/favourite_cubit/favourite_cubit.dart';
import 'package:elbahreen/business_logic/store_cubit/stores_cubit.dart';
import 'package:elbahreen/constants/end_points.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/view/store_details_body_view.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateCubit() : super(RateInitial());

  static RateCubit get(context) => BlocProvider.of(context);
  String updatedRate = "0.0";

  Future setStoreRate({
    required int storeId,
    required double rate,
    required VoidCallback afterSuccess,
    required VoidCallback afterFail,
   // required BuildContext context,
  }) async {
    try {
      await DioHelper.getData(url: setRate, query: {
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "DAWB3H2aLBx5x4knhTGgN8uxxcrnDmi5Yn56Q95L",
        "storeId": storeId,
        "rate": rate,
      }).then((value) {
        print("1111111111111111111111111" "${value.data.toString()}"); 
        print(value.data['data']['avg_rate']);
        CacheHelper.saveDataSharedPreference(key: "$storeId", value: "${value.data['data']['avg_rate']}"); 
        print(updatedRate);
        afterSuccess();
        //FavouriteCubit.get(context).getFavouriteStores();
        emit(UpdateRateState());
      });
    } on DioError catch (dioError) {
      print("222222222222222222222222" "${dioError.toString()}");
      //print(dioError.toString());
      afterFail();
    } catch (error) {
      print("333333333333333333333333333" "${error.toString()}");
      print(error.toString());
      afterFail();
    }
  }

  Future updateStoreRate({
    required int storeId,
    required double rate,
    required VoidCallback afterSuccess,
  }) async {
    try {
      await DioHelper.getData(url: updateRate, query: {
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "DAWB3H2aLBx5x4knhTGgN8uxxcrnDmi5Yn56Q95L",
        "storeId": storeId,
        "rate": rate,
      }).then((value) {
        print("4444444444444444444444" "${value.data.toString()}");
        print("rate is updated" "${value.data.toString()}");
        afterSuccess();
      });
    } on DioError catch (dioError) {
      // print(dioError.response!.data.toString());
      print("5555555555555555555555" "${dioError.response.toString()}");
      // print("5555555555555555555555" "${dioError.response["message"]}");
    } catch (error) {
      print("6666666666666666666666" "${error.toString()}");
      //print(error.toString());
    }
  }
}
