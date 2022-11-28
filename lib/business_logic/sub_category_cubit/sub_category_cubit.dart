import 'package:dio/dio.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../constants/end_points.dart';
import '../../data/network/responses/sub_categories_response.dart';
import 'sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit() : super(CategoriesInitialState());

  static SubCategoryCubit get(context) => BlocProvider.of(context);

  List<dynamic> subCategories = [];
  SubCategoriesResponse? subCategoriesResponse;
  bool finished = false;
  getSubCategories({required int categoryId, required int page}) async {
    emit(LoadingGetSubCategoriesState());
    print(categoryId);
    print(page);
    try {
      Response response =
          await DioHelper.getData(url: epGetSubCategories, query: {
        "categoryId": categoryId,
        "language":
            CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar",
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId") ??
            "grBTkk83oDTVxAwHkrgTQttuDgjB4gav7k04Tehu",
        "page": page
      });
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorGetSubCategoriesState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      subCategoriesResponse = SubCategoriesResponse.fromJson(response.data);
      if (subCategoriesResponse!.subCategories.isEmpty) {
        emit(EmptySubCategoriesState());
      } else {
        if (subCategoriesResponse!.subCategories.length < 20) {
          finished = true;
        }
        subCategories.addAll(subCategoriesResponse!.subCategories);
        //print("suuuuuuuuuuuuubCaaaaaaaaaaaaaaaaategory$subCategories");
        emit(SuccessGetSubCategoriesState());
      }
    } on DioError catch (exception) {
      print(exception.response);
      emit(ErrorGetSubCategoriesState(exception.toString()));
    }
  }
}
