import 'package:elbahreen/presentation/router/app_router_names.dart';
import 'package:elbahreen/presentation/view/side_menu_view.dart';
import 'package:elbahreen/presentation/view/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';
import '../../../business_logic/filter_cubit/filter_cubit.dart';
import '../../../business_logic/filter_cubit/filter_states.dart';
import '../../../constants/app_strings.dart';
import '../../router/arguments/filter_arguments.dart';
import '../../view/filter_component_view.dart';
import '../../widget/default_text.dart';
import '../../widget/default_button.dart';
import '../../styles/colors.dart';

class FilterSearchScreen extends StatefulWidget {
  const FilterSearchScreen(this.arguments, {Key? key}) : super(key: key);

  final FilterArguments arguments;

  @override
  State<FilterSearchScreen> createState() => _FilterSearchScreenState();
}

class _FilterSearchScreenState extends State<FilterSearchScreen> {
  int districtId = 0;
  String subCategory = "";
  int subCategoryId = 0;

  @override
  Widget build(BuildContext context) {
    print("filter screen heeeeeeeeeeeeere");
    return BlocProvider(
      create: (context) => FilterCubit()
        ..getSubCategories(categoryId: widget.arguments.categoryId, page: 0)
        ..getDistrict(),
      child: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          FilterCubit cubit = FilterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(translate(AppStrings.sFilter),
                  style: TextStyle(fontSize: 11.sp)),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              actions: [
                Builder(
                  builder: (context) {
                    return IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => Scaffold.of(context).openDrawer());
                  },
                ),
              ],
            ),
            drawer: const SideMenuView(),
            drawerEnableOpenDragGesture: false,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 8.h),
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                        text: translate(AppStrings.sViewByType), size: 14.sp),
                    SizedBox(height: .5.h),
                    widget.arguments.isNotEmpty
                        ? FilterComponentView(
                            text: translate(AppStrings.sBuildingType),
                            value: cubit.subCategory,
                            items: FilterCubit.get(context)
                                .subCategories
                                .toSet()
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                subCategoryId = int.parse(
                                    FilterCubit.get(context).subCategoriesIds[
                                        FilterCubit.get(context)
                                            .subCategories
                                            .indexOf(value!)]);
                              });
                              print(subCategoryId);
                              cubit.changeSubCategory(value.toString());
                            },
                          )
                        : FilterComponentView(
                            text: translate(AppStrings.sBuildingType),
                            value: cubit.subCategory,
                            items: [widget.arguments.subCategory].toList(),
                            onChanged: (value) {
                              setState(() {
                                subCategoryId = widget.arguments.subCategoryId!;
                              });
                              print(subCategoryId);
                              cubit.changeSubCategory(value.toString());
                            },
                          ),
                    SizedBox(height: 2.h),
                    const Divider(color: AppColor.red),
                    SizedBox(height: 2.h),
                    DefaultText(
                        text: translate(AppStrings.sViewByLocation),
                        size: 14.sp),
                    SizedBox(height: .5.h),
                    FilterComponentView(
                        text: translate(AppStrings.sSelectLocation),
                        value: cubit.district,
                        items:
                            FilterCubit.get(context).districts.toSet().toList(),
                        onChanged: (value) {
                          setState(() {
                            subCategory = value;
                            districtId = int.parse(
                                FilterCubit.get(context).districtsIds[
                                    FilterCubit.get(context)
                                        .districts
                                        .indexOf(value!)]);
                          });
                          print(districtId);
                          print(subCategory);
                          cubit.changeDistrict(value);
                        }),
                    SizedBox(height: 15.h),
                    // search button
                    DefaultButton(
                      text: translate(AppStrings.sSearch),
                      press: () {
                        if (districtId != 0 || subCategoryId != 0) {
                          cubit.filter(
                              subCategoryId: subCategoryId,
                              district: districtId,
                              page: 0,
                              afterSuccess: () {
                                Navigator.pushNamed(
                                    context, AppRouterNames.rFilterResult,
                                    arguments: FilterArguments(
                                      widget.arguments.categoryId,
                                      subCategoryId: subCategoryId,
                                      districtId: districtId, 
                                      subCategory: subCategory,
                                    ));
                              });
                        } else {
                          print("$districtId ////// $subCategoryId");
                          showToast(
                              "اختر النوع او المنطقة لكي تتم عملية البحث");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
