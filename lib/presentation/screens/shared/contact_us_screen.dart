import 'package:elbahreen/business_logic/contact_us_cubit/contact_us_cubit.dart';
import 'package:elbahreen/business_logic/contact_us_cubit/contact_us_state.dart';
import 'package:elbahreen/presentation/styles/colors.dart';
import 'package:elbahreen/presentation/view/side_menu_view.dart';
import 'package:elbahreen/presentation/view/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_strings.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return BlocProvider(
      create: (context) => ContactUsCubit()..getContacts(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate(AppStrings.sContactUS),style: TextStyle(fontSize: 11.sp)),
          leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => Scaffold.of(context).openDrawer());
            },
          ),
        ),
        drawer: const SideMenuView(),
        drawerEnableOpenDragGesture: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(2.h) + EdgeInsets.only(top: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<ContactUsCubit, ContactUsState>(
                builder: (context, state) {
                  if(state is! ContactUsSuccess){
                    return Card(
                      margin: EdgeInsets.all(1.h),
                      elevation: 2,
                      shadowColor: AppColor.white.withOpacity(0.3),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: AppColor.grey,
                                  size: 20.sp,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  color: AppColor.grey,
                                  size: 20.sp,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Card(
                    margin: EdgeInsets.all(1.h),
                    elevation: 2,
                    shadowColor: AppColor.white.withOpacity(0.3),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_android,
                                color: AppColor.grey,
                                size: 20.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                ContactUsCubit.get(context).contactsPhone,
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: AppColor.grey,
                                size: 20.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                ContactUsCubit.get(context).contactsEmail,
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 5.h),
              TextField(
                controller: nameController,
                style: const TextStyle(color: AppColor.black),
                decoration: InputDecoration(
                  hintText: translate(AppStrings.sName),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.h),
                  hintStyle: const TextStyle(color: AppColor.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    borderSide: const BorderSide(color: AppColor.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    borderSide: const BorderSide(color: AppColor.grey),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: phoneController,
                style: const TextStyle(color: AppColor.black),
                decoration: InputDecoration(
                  hintText: translate(AppStrings.sPhone),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.h),
                  hintStyle: const TextStyle(color: AppColor.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    borderSide: const BorderSide(color: AppColor.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    borderSide: const BorderSide(color: AppColor.grey),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                style: const TextStyle(color: AppColor.black),
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: translate(AppStrings.sWriteYourMessage),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.h),
                  hintStyle: const TextStyle(color: AppColor.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    borderSide: const BorderSide(color: AppColor.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    borderSide: const BorderSide(color: AppColor.grey),
                  ),
                  isDense: true,
                ),
                maxLines: 5,
              ),
              SizedBox(height: 10.h),
              BlocConsumer<ContactUsCubit, ContactUsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return Center(
                              child: SizedBox(
                                width: 15.w,
                                height: 15.w,
                                child: const CircularProgressIndicator(),
                              ),
                            );
                          },
                        );
                        _validateSendMessage(context);
                      },
                      child: Text(translate(AppStrings.sSend)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateSendMessage(BuildContext context) {
    if (_messageController.text.trim().isNotEmpty) {
      ContactUsCubit.get(context).sendMessage(
        name: nameController.text,
        phone: phoneController.text,
        message: _messageController.text,
        afterSuccess: () {
          showToast(translate(AppStrings.sMessageSent));
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translate(AppStrings.sMessageIsEmpty))));
    }
  }
}
