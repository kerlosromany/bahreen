import 'package:dio/dio.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../constants/end_points.dart';
import '../../data/network/responses/stores_response.dart';
import 'stores_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoresInitialState());

  static StoreCubit get(context) => BlocProvider.of(context);

  StoresResponse? storesResponse;
  List<dynamic> stores = [];
  bool finished = false;

  getStores({int? subCategoryId, int? page}) async {
    emit(LoadingGetStoresState());
    stores = [];
    try {
      Response response = await DioHelper.getData(url: epGetStores, query: {
        "language": CacheHelper.getDataFromSharedPreference(key: 'language'),
        "deviceId": CacheHelper.getDataFromSharedPreference(key: "deviceId"), 
        "subCategoryId": subCategoryId,
        "page": page,
      });
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorGetStoresState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      storesResponse = StoresResponse.fromJson(response.data);
      // print("//////////////////////////////////////////////////////"
      //     "${response.data}");
      if (storesResponse!.stores.isEmpty) {
        emit(EmptyStoresState());
      } else {
        if (storesResponse!.stores.length < 20) {
          finished = true;
          print(
              "=========================================================================="); 
        }
        stores.addAll(storesResponse!.stores);
        emit(SuccessGetStoresState());
        print(stores);
      }
    } on DioError catch (exception) {
      print(exception.response);
      emit(ErrorGetStoresState(exception.toString()));
    }
  }
}
