import 'package:dio/dio.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:elbahreen/data/network/responses/districts_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../constants/end_points.dart';
import '../../data/network/responses/filter_response.dart';
import '../../data/network/responses/sub_categories_response.dart';
import 'filter_states.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitialState());

  static FilterCubit get(context) => BlocProvider.of(context);

  String? subCategory;

  void changeSubCategory(String value) {
    subCategory = value;
    emit(ChangeSubCategoryState());
  }

  String? district;

  void changeDistrict(String value) {
    district = value;
    emit(ChangeDistrictState());
  }

  List<String> subCategories = [];
  List<String> subCategoriesIds = [];
  SubCategoriesResponse? subCategoriesResponse;

  getSubCategories({required int categoryId, required int page}) async {
    emit(LoadingSubCategoryState());
    try {
      Response response =
          await DioHelper.getData(url: epGetSubCategories, query: {
        "categoryId": categoryId,
        "language": CacheHelper.getDataFromSharedPreference(key: 'language'),
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId"),
        "page": page
      });
      // print(response.data);
      subCategoriesResponse = SubCategoriesResponse.fromJson(response.data);
      for (int i = 0; i < subCategoriesResponse!.subCategories.length; i++) {
        subCategories.add(subCategoriesResponse!.subCategories[i]['name']);
        subCategoriesIds
            .add(subCategoriesResponse!.subCategories[i]['id'].toString());
      }
      emit(SuccessSubCategoryState());
      print(subCategories.length);
    } on DioError catch (exception) {
      print(exception.response!.data.toString());
      emit(ErrorSubCategoryState(exception.response!.data.toString()));
      print("this error happened" "${exception.response.toString()}");
    }
  }

  DistrictsResponse? districtsResponse;
  List<String> districts = [];
  List<String> districtsIds = [];

  getDistrict({int? page}) async {
    emit(LoadingGetDistrictsState());
    try {
      Response response = await DioHelper.getData(
        url: epGetDistricts,
        query: {
          "language": CacheHelper.getDataFromSharedPreference(key: 'language'),
          "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId"),
          "page": page,
        },
      );
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorGetDistrictsState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      districtsResponse = DistrictsResponse.fromJson(response.data);
      for (int i = 0; i < districtsResponse!.districts.length; i++) {
        districts.add(districtsResponse!.districts[i]['name']);
        districtsIds.add(districtsResponse!.districts[i]['id'].toString());
      }
      print(districts.length);
      emit(SuccessGetDistrictsState());
    } on DioError catch (exception) {
      print(exception.response!.data);
      emit(ErrorGetDistrictsState(exception.toString()));
    }
  }

  List<dynamic> filterResult = [];
  FilterResponse? filterResponse;

  filter(
      {required int page,
      required int subCategoryId,
      required int district,
      required VoidCallback afterSuccess}) async {
    emit(LoadingFilterState());
    filterResult = [];
    try {
      Response response = await DioHelper.getData(
        url: epFilter,
        query: subCategoryId == 0 && district == 0
            ? {
                "language":
                    CacheHelper.getDataFromSharedPreference(key: 'language'),
                "deviceId":
                    CacheHelper.getDataFromSharedPreference(key: "deviceId"),
                "page": page
              }
            : subCategoryId == 0 && district != 0
                ? {
                    "language": CacheHelper.getDataFromSharedPreference(
                        key: 'language'),
                    "deviceId": CacheHelper.getDataFromSharedPreference(
                        key: "deviceId"),
                    "page": page,
                    "districtId": district,
                  }
                : subCategoryId != 0 && district == 0
                    ? {
                        "language": CacheHelper.getDataFromSharedPreference(
                            key: 'language'),
                        "deviceId": CacheHelper.getDataFromSharedPreference(
                            key: "deviceId"),
                        "subCategoryId": subCategoryId,
                        "page": page
                      }
                    : {
                        "language": CacheHelper.getDataFromSharedPreference(
                            key: 'language'),
                        "deviceId": CacheHelper.getDataFromSharedPreference(
                            key: "deviceId"),
                        "districtId": district,
                        "subCategoryId": subCategoryId,
                        "page": page
                      },
      );
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorFilterState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      filterResponse = FilterResponse.fromJson(response.data);
      filterResult.addAll(filterResponse!.stores);
      print(filterResult);
      print("filterResultLength ${filterResult.length}");
      //print(filterResult.length);
      if (filterResult.isEmpty) {
        emit(EmptyFilterState());
      } else {
        emit(SuccessFilterState());
      }
      afterSuccess();
    } on DioError catch (exception) {
      print("Exception is ${exception.toString()}");
      emit(ErrorFilterState(exception.toString()));
    }
  }
}
