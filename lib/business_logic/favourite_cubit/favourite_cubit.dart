import 'package:dio/dio.dart';
import 'package:elbahreen/constants/end_points.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  static FavouriteCubit get(context) => BlocProvider.of(context);

  List<dynamic> stores = [];
  bool finished = false;

  Future addStoreToFavourite({
    required int storeId,
    required VoidCallback afterSuccess,
    required VoidCallback afterFail,
    required String subCategoryTitle,
  }) async {
    try {
      await DioHelper.getData(url: addFavourite, query: {
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "DAWB3H2aLBx5x4knhTGgN8uxxcrnDmi5Yn56Q95L",
        "storeId": storeId,
      }).then((value) {
        print("response for add to favorite${value.data.toString()}");
        afterSuccess();
      });
    } on DioError catch (dioError) {
      //print(dioError.toString());
      afterFail();
    } catch (error) {
      //print(error.toString());
      afterFail();
    }
  }

  Future getFavouriteStores() async {
    emit(FavouriteLoading());
    try {
      await DioHelper.getData(url: getFavourites, query: {
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "DAWB3H2aLBx5x4knhTGgN8uxxcrnDmi5Yn56Q95L",
        "language":
            CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar",
      }).then((value) {
        // print(value.data['data'].toString());

        // print(
        //     "/////////////////////////////${value.data.toString()}///////////////////////");
        stores.addAll(value.data['data']);
        // print(value.data['data']['name']);
        // print(value.data['data']['rate']);

        if (stores.length < 20) {
          finished = true;
        }
        if (stores.isEmpty) {
          emit(FavouriteEmpty());
        } else {
          emit(FavouriteSuccess());
        }
      });
    } on DioError catch (dioError) {
      print(dioError.toString());
      emit(FavouriteFail());
    } catch (error) {
      print(error.toString());
      emit(FavouriteFail());
    }
  }

  Future deleteStoreToFavourite({
    required int storeId,
    required VoidCallback afterSuccess,
    required VoidCallback afterFail,
  }) async {
    try {
      await DioHelper.getData(url: deleteFavourite, query: {
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "DAWB3H2aLBx5x4knhTGgN8uxxcrnDmi5Yn56Q95L",
        "storeId": storeId,
      }).then((value) {
        print(value.data.toString());
        afterSuccess();
        
      });
    } on DioError catch (dioError) {
      print(dioError.toString());
      afterFail();
    } catch (error) {
      print(error.toString());
      afterFail();
    }
  }
}
