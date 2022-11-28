import 'dart:io';

import 'package:elbahreen/presentation/view/toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../business_logic/global_cubit/global_state.dart';
import '../../../data/data_provider/local/cache_helper.dart';
import '../../widget/my_custom_container.dart';
import '../../widget/text_form_field_widget.dart';

class JoinTraderScreen extends StatefulWidget {
  JoinTraderScreen({Key? key}) : super(key: key);

  @override
  State<JoinTraderScreen> createState() => _JoinTraderScreenState();
}

class _JoinTraderScreenState extends State<JoinTraderScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  // String nameText = "";
  // getLatest() {
  //   setState(() {
  //     nameText = nameController.text;
  //   });
  // }

  TextEditingController shopController = TextEditingController();
  // String shopText = "";
  // getLatest2() {
  //   setState(() {
  //     shopText = shopController.text;
  //   });
  // }

  TextEditingController addressController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController whatsappMobileController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   nameController.addListener(getLatest);
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = GlobalCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            opacity: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 0.06 * screenHeight),
                 Text(
                 CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ? "انضم كتاجر" : "Join as a trader",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                SizedBox(height: 0.03 * screenHeight),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        controller: nameController,
                        hintTxt: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ?"الاسم بالكامل" : "Your name",
                        textInputType: TextInputType.name,
                        textValidation: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ? "ادخل اسمك" : "Enter your name",
                        //text: nameText,
                      ),
                      SizedBox(height: 0.018 * screenHeight),
                      TextFormFieldWidget(
                        controller: shopController,
                        hintTxt: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ?"اسم المتجر " : "Shop name",
                        textInputType: TextInputType.name,
                        textValidation: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ?"ادخل سم المتجر" : "Enter the shop name",
                        //text: shopText,
                      ),
                      SizedBox(height: 0.018 * screenHeight),
                      TextFormFieldWidget(
                        controller: addressController,
                        hintTxt: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ?"عنوان المتجر الرئيسي " : "the main store address",
                        textInputType: TextInputType.name,
                        textValidation: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ? "ادخل عنوان المتجر" : "ُEnter the shop address",
                      ),
                      SizedBox(height: 0.018 * screenHeight),
                      BlocBuilder<GlobalCubit, GlobalState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MyCustomContainer(
                                widget: FittedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children:  [
                                      const Icon(Icons.menu),
                                      Text(CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ?"ادخل عناوين الفروع" : "Enter branch addresses"),
                                    ],
                                  ),
                                ),
                                height: 0.06 * screenHeight,
                                width: 0.6 * screenWidth,
                              ),
                              FloatingActionButton(
                                onPressed: cubit.addDynamic,
                                child: const Icon(Icons.add),
                                backgroundColor: Colors.grey,
                                elevation: 10,
                              )
                            ],
                          );
                        },
                      ),
                      if (cubit.listDynamic.isEmpty) const SizedBox(),
                      if (cubit.listDynamic.isNotEmpty)
                        BlocBuilder<GlobalCubit, GlobalState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 0.15 * screenHeight,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return cubit.listDynamic[index];
                                },
                                itemCount: cubit.listDynamic.length,
                              ),
                            );
                          },
                        ),
                      SizedBox(height: 0.018 * screenHeight),
                      MyCustomContainer(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () => cubit.pickImage(context),
                              child: MyCustomContainer(
                                width: 0.4 * screenWidth,
                                height: 0.06 * screenHeight,
                                widget:  FittedBox(
                                    child: Text(CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ?"أختر صورة الشعار" : "Choose a logo image")),
                                alignment: Alignment.center,
                              ),
                            ),
                            cubit.image != null
                                ? Image.file(
                                    cubit.image!,
                                    width: 0.22 * screenWidth,
                                    height: 0.1 * screenHeight,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 0.22 * screenWidth,
                                    height: 0.1 * screenHeight,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ],
                        ),
                        height: 0.12 * screenHeight,
                        width: double.infinity,
                      ),
                      SizedBox(height: 0.018 * screenHeight),
                      TextFormFieldWidget(
                        controller: mobileController,
                        hintTxt: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ?"رقم الجوال " : "Phone number",
                        textInputType: TextInputType.phone,
                        textValidation:CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ?  "ادخل رقم الجوال" : "Enter phone number",
                      ),
                      SizedBox(height: 0.018 * screenHeight),
                      TextFormFieldWidget(
                        controller: whatsappMobileController,
                        hintTxt: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ? "رقم الواتس اب " : "Whatsapp number",
                        textInputType: TextInputType.phone,
                        textValidation: CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar' ? "ادخل رقم الواتس اب" : "Enter whatsapp number",
                      ),
                      SizedBox(height: 0.06 * screenHeight),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                          height: 0.07 * screenHeight,
                          width: double.infinity,
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.of(context).pop();
                                showToast(
                                    CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar'
                      ? "لقد تم تسجيل ردك و سيتم ارسال طلبك للادارة و يكون الرد خلال 48 ساعة" : "Your response has been recorded, and your request will be sent to the administration, and the response will be within 48 hours.");
                              }

                              // cubit.listDynamic.forEach(
                              //     (element) => print(element.controller.text));
                            },
                            child: MyCustomContainer(
                              height: 0.06 * screenHeight,
                              width: 0.26 * screenWidth,
                              alignment: Alignment.center,
                              color: Colors.black,
                              borderWidth: 3,
                              widget: FittedBox(
                                child: Text(
                                  CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar'
                      ?"انضمام" : "Join",
                                  style: const TextStyle(fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
