import 'package:dio/dio.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:elbahreen/data/network/responses/contacts_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../constants/end_points.dart';
import 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitialState());

  static ContactUsCubit get(context) => BlocProvider.of(context);

  String? contactUs;

  sendMessage({
    String? name,
    String? phone,
    required String message,
    required VoidCallback afterSuccess,
  }) async {
    emit(LoadingGetContactUsState());
    try {
      Response response = await DioHelper.postData(
        url: epContact,
        body: {
          "language":CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar",
          "message":message,
          "phone":phone,
          "name":name,
        }
      );
      if (response.statusCode != SUCCESS_CODE) {
        emit(ErrorGetContactUsState(response.statusMessage ?? DEF_ERROR));
        return;
      }
      afterSuccess();
      print(response.data);
      emit(SuccessGetContactUsState());
    } on DioError catch (exception){
      emit(ErrorGetContactUsState(exception.toString()));
    }
  }

  ContactsResponse? contactsResponse;
  String contactsPhone = "";
  String contactsEmail = "";
  getContacts() async {
    emit(ContactUsLoading());
    try {
      DioHelper.getData(url: "getContacts").then((value) {
        print(value.data["contacts"]);
        contactsResponse = ContactsResponse.fromJson(value.data);
        contactsPhone = contactsResponse!.contactsModel.phones[0];
        contactsEmail = contactsResponse!.contactsModel.emails[0];
        print(contactsPhone);
        print(contactsEmail);
        emit(ContactUsSuccess());
      });
    } catch (error) {
      emit(ContactUsFail());
      print(error.toString());
    }
  }
}
