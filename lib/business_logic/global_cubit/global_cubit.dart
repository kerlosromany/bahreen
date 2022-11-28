import 'dart:convert';
import 'dart:io';

import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:elbahreen/data/models/store_object.dart';
import 'package:elbahreen/data/network/responses/about_us_response.dart';
import 'package:elbahreen/data/network/responses/search_response.dart';
import 'package:elbahreen/data/network/responses/un_seen_notifications_response.dart';
import 'package:elbahreen/main.dart';
import 'package:elbahreen/presentation/view/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';
import '../../constants/end_points.dart';
import '../../data/network/responses/ads_response.dart';
import '../../data/network/responses/categories_response.dart';
import '../../presentation/widget/text_form_field_widget.dart';
import 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        CacheHelper.saveDataSharedPreference(key: "isConnected", value: true);
      }
    } on SocketException catch (_) {
      CacheHelper.saveDataSharedPreference(key: "isConnected", value: false);
      print('not connected');
    }
  }

  AboutUsResponse? aboutUsResponse;

  getAboutUs() async {
    try {
      await DioHelper.getData(
        url: epAboutUs,
        query: {
          "language":
              CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar",
        },
      ).then((value) {
        aboutUsResponse = AboutUsResponse.fromJson(value.data);
        url = aboutUsResponse!.aboutUs['url'];
        print(aboutUsResponse!.aboutUs['url']);
        print(url);
      });
    } catch (exception) {
      print(exception.toString());
    }
  }

  Future getFirstUser() async {
    try {
      await DioHelper.getData(
        url: epGetFirstUser,
      ).then((value) {
        CacheHelper.saveDataSharedPreference(
            key: "deviceId", value: value.data['device_id']);
        CacheHelper.saveDataSharedPreference(
            key: "firebase_token", value: value.data['firebase_token']);
        print(value.data['device_id']);
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  void toArabic({
    required VoidCallback afterSuccess,
  }) {
    CacheHelper.saveDataSharedPreference(key: 'language', value: "ar");
    delegate.changeLocale(const Locale("ar"));
    categoriesList = [];
    getCategories(page: 0);
    afterSuccess();
  }

  void toEnglish({
    required VoidCallback afterSuccess,
  }) {
    CacheHelper.saveDataSharedPreference(key: 'language', value: "en");
    delegate.changeLocale(const Locale("en"));
    categoriesList = [];
    getCategories(page: 0);
    afterSuccess();
  }

  AdsResponse? adsResponse;

  getAds() async {
    emit(LoadingGetAdsState());
    try {
      Response response = await DioHelper.getData(url: epAds, query: {
        "language":
            CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar",
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "grBTkk83oDTVxAwHkrgTQttuDgjB4gav7k04Tehu",
      });
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorGetAdsState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      adsResponse = AdsResponse.fromJson(response.data);
      print(adsResponse!.ads);
      emit(SuccessGetAdsState());
    } on DioError catch (exception) {
      emit(ErrorGetAdsState(exception.toString()));
    }
  }

  CategoriesResponse? categoriesResponse;
  List<dynamic> categoriesList = [];
  bool finished = false;

  getCategories({int? page}) async {
    emit(LoadingGetCategoriesState());
    try {
      Response response = await DioHelper.getData(url: epGetCategories, query: {
        "language":
            CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar",
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "DAWB3H2aLBx5x4knhTGgN8uxxcrnDmi5Yn56Q95L",
        "page": page
      });
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorGetCategoriesState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      categoriesResponse = CategoriesResponse.fromJson(response.data);
      if (categoriesResponse!.categories.length < 20) {
        finished = true;
      }
      if (categoriesResponse!.categories.isEmpty) {
        emit(EmptyCategoriesState());
      } else {
        categoriesList.addAll(categoriesResponse!.categories);
        print("categoriesList categoriesList categoriesList categoriesList "
            "$categoriesList");
        emit(SuccessGetCategoriesState());
      }
    } on DioError catch (exception) {
      print(exception.response!.data.toString());
      emit(ErrorGetCategoriesState(exception.toString()));
    }
  }

  UnSeenNotificationsResponse? unSeenNotificationsResponse;

  getUnSeenNotifications() async {
    emit(LoadingGetUnSeenState());
    try {
      Response response =
          await DioHelper.getData(url: epUnSeenNotifications, query: {
        "language":
            CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar",
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "grBTkk83oDTVxAwHkrgTQttuDgjB4gav7k04Tehu",
      });
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorGetUnSeenState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      unSeenNotificationsResponse =
          UnSeenNotificationsResponse.fromJson(response.data);
      emit(SuccessGetUnSeenState());
    } on DioError catch (exception) {
      emit(ErrorGetUnSeenState(exception.toString()));
    }
  }

  SearchResponse? searchResponse;
  List<dynamic> categoryObject = [];
  List<dynamic> subCategoryObject = [];
  List<dynamic> storeObject = [];

  searchStore(int page, String keyword, VoidCallback afterSuccess) async {
    emit(SearchLoadingState());
    categoryObject = [];
    subCategoryObject = [];
    storeObject = [];
    try {
      Response response = await DioHelper.getData(url: epSearch, query: {
        "language":
            CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar",
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "grBTkk83oDTVxAwHkrgTQttuDgjB4gav7k04Tehu",
        "keyword": keyword,
        "page": page,
      });
      if (response.statusCode != SUCCESS_CODE) {
        emit(SearchErrorState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      searchResponse = SearchResponse.fromJson(response.data);
      if (searchResponse!.data["categories"].isEmpty &&
          searchResponse!.data["subCcategories"].isEmpty) {
        emit(SearchEmptyState());
      } else {
        categoryObject.addAll(searchResponse!.data["categories"]);
        storeObject.addAll(searchResponse!.data["stores"]);
        subCategoryObject.addAll(searchResponse!.data["subCcategories"]);
        emit(SearchSuccessState());
      }
      afterSuccess();
    } on DioError catch (exception) {
      print(exception.response);
      emit(SearchErrorState(exception.toString()));
    }
  }

  Future<void> addToSp(List<List<StoreObject>> tList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('storesFav', jsonEncode(tList));
  }

  // join trader screen logic

  List<TextFormFieldWidget> listDynamic = [];
  addDynamic() {
    listDynamic.add(TextFormFieldWidget(
      controller: TextEditingController(),
      hintTxt: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ? "ادخل اسم الفرع" :"Enter the branch name",
      textInputType: TextInputType.name,
      textValidation:CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ? "ادخل اسم الفرع" : "Enter the branch name",
      widget: IconButton(
        onPressed: () {
          listDynamic.removeLast();
          emit(RemoveFromListState());
        },
        icon: const Icon(Icons.clear),
      ),
    ));
    emit(AddToListState());
  }

  File? image;
  Future pickImage(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      this.image = imageTemp;
      emit(ChangePhotoState());
    } on PlatformException catch (e) {
      print("the error is ${e.toString()}");
      showToast(CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ? "خطأ في التقاط الصورة":"Failed to pick image");
    }
  }
}
