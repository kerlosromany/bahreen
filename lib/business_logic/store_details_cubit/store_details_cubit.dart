import 'package:dio/dio.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:elbahreen/data/network/responses/sub_categories_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../constants/end_points.dart';
import 'store_details_state.dart';

class StoreDetailsCubit extends Cubit<StoreDetailsState> {
  StoreDetailsCubit() : super(StoreDetailsInitialState());

  static StoreDetailsCubit get(context) => BlocProvider.of(context);

  String? subCategoryName;
  SubCategoriesResponse? subCategoriesResponse;

  getSubCategoryName(int categoryId, int subCategoryId) async {
    emit(LoadingStoreDetailsState());
    try {
      Response response =
          await DioHelper.getData(url: epGetSubCategories, query: {
        "categoryId": categoryId,
        "language": CacheHelper.getDataFromSharedPreference(key: 'language'),
      });
      print("//////////////////////////////////////////////////////"
          "${response.data}");
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorStoreDetailsState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      subCategoriesResponse = SubCategoriesResponse.fromJson(response.data);
      emit(SuccessStoreDetailsState());
      subCategoryName = (subCategoriesResponse!.subCategories
        ..firstWhere((element) {
          return element.id == subCategoryId;
        }).name) as String?;
    } catch (exception) {
      emit(ErrorStoreDetailsState(exception.toString()));
    }
  }
}
