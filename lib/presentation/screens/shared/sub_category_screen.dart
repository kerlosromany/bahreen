import 'dart:async';

import 'package:elbahreen/business_logic/global_cubit/global_cubit.dart';
import 'package:elbahreen/presentation/router/arguments/stores_arguments.dart';
import 'package:elbahreen/presentation/screens/shared/stores_screen.dart';
import 'package:elbahreen/presentation/view/category_view.dart';
import 'package:elbahreen/presentation/view/loading_view.dart';
import 'package:elbahreen/presentation/view/side_menu_view.dart';
import 'package:elbahreen/presentation/widget/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/sub_category_cubit/sub_category_cubit.dart';
import '../../../business_logic/sub_category_cubit/sub_category_state.dart';
import '../../../constants/app_strings.dart';
import '../../router/app_router_names.dart';
import '../../router/arguments/filter_arguments.dart';
import '../../router/arguments/sub_category_argument.dart';
import '../../styles/colors.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen(this.arguments, {Key? key}) : super(key: key);

  final SubCategoryArguments arguments;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final controller = ScrollController();
  TextEditingController searchController = TextEditingController();
  int page = 0;
  bool isSearch = false;
  Timer? timer;
  int second = 5;

  // void startTimer() {
  //   setState(() {
  //     second = 5;
  //   });
  //   const oneSec = Duration(seconds: 1);
  //   timer = Timer.periodic(
  //     oneSec,
  //         (Timer timer) {
  //       if (second == 0) {
  //         setState(() {
  //           timer.cancel();
  //         });
  //       } else {
  //         setState(() {
  //           second--;
  //         });
  //       }
  //     },
  //   );
  // }

  @override
  initState() {
    // if (SubCategoryCubit.get(context).subCategories.length < 20) {
    //   setState(() {
    //     finished = true;
    //   });
    // }
    //startTimer();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        SubCategoryCubit.get(context).getSubCategories(
            categoryId: widget.arguments.categoryId, page: page);
        setState(() {
          page = page + 1;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    print("Dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Sub category screen is came");
    return BlocProvider(
      create: ((context) => SubCategoryCubit()
        ..getSubCategories(
          categoryId: widget.arguments.categoryId,
          page: page,
        )),
      child: BlocBuilder<SubCategoryCubit, SubCategoryState>(
        builder: (context, state) {
          if (SubCategoryCubit.get(context).subCategories.length == 1) {
            return StoresScreen(
              StoresArguments(
                widget.arguments.categoryId,
                SubCategoryCubit.get(context).subCategories[0]['id'],
                SubCategoryCubit.get(context).subCategories[0]['name'],
                false,
                "",
              ),
            );
          }
          return Scaffold(
            appBar: SubCategoryCubit.get(context).subCategories.length == 1
                ? AppBar()
                : AppBar(
                    title: isSearch
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  style: const TextStyle(color: Colors.white),
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                    hintText: translate(AppStrings.sSearch),
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : getTitle,
                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    actions: [
                      IconButton(
                          onPressed: () {
                            searchController.text = '';
                            setState(() {
                              isSearch = !isSearch;
                            });
                          },
                          icon: Icon(isSearch ? Icons.cancel : Icons.search)),
                      GestureDetector(
                        onTap: () {
                          isSearch
                              ? {
                                  GlobalCubit.get(context).searchStore(
                                      0, searchController.text, () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRouterNames.rSearch,
                                      arguments: StoresArguments(
                                        1,
                                        1,
                                        "",
                                        true,
                                        searchController.text,
                                      ),
                                    );
                                  }),
                                }
                              : {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouterNames.rFilterRoute,
                                    arguments: FilterArguments(
                                      widget.arguments.categoryId,
                                    ),
                                  )
                                };
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 3.w,
                            left: 3.w,
                          ),
                          child: isSearch
                              ? const Icon(Icons.search)
                              : Image.asset(
                                  'assets/icons/filter.png',
                                  height: 22,
                                  width: 22,
                                  color: AppColor.white,
                                ),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          return IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer());
                        },
                      ),
                    ],
                  ),
            drawer: const SideMenuView(),
            drawerEnableOpenDragGesture: false,
            body: BlocBuilder<SubCategoryCubit, SubCategoryState>(
              builder: (context, state) {
                if (state is EmptySubCategoriesState) {
                  return Center(
                    child: DefaultText(
                      text: translate(AppStrings.noDataFound),
                    ),
                  );
                } else if (state is SuccessGetSubCategoriesState) {
                  return SizedBox(
                    width: 100.w,
                    height: 90.h,
                    child: GridView.count(
                      controller: controller,
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.h, vertical: 1.5.h),
                      crossAxisCount: 3,
                      children: List.generate(
                        SubCategoryCubit.get(context).subCategories.length + 1,
                        (index) => index <
                                SubCategoryCubit.get(context)
                                    .subCategories
                                    .length
                            ? CategoryView(
                                title: SubCategoryCubit.get(context)
                                    .subCategories[index]['name'],
                                imageUrl: SubCategoryCubit.get(context)
                                    .subCategories[index]['image'],
                                index: index,
                                id: SubCategoryCubit.get(context)
                                    .subCategories[index]['id'],
                                route: AppRouterNames.rStoreRoute,
                                arguments: StoresArguments(
                                  widget.arguments.categoryId,
                                  SubCategoryCubit.get(context)
                                      .subCategories[index]['id'],
                                  SubCategoryCubit.get(context)
                                      .subCategories[index]['name'],
                                  false,
                                  "",
                                ),
                              )
                            : SubCategoryCubit.get(context).finished
                                ? const SizedBox()
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                      ),
                    ),
                  );
                }
                return GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(
                    21,
                    (index) => LoadingView(
                      height: 10.h,
                      width: 10.h,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  get getSearchField => Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: AppColor.white),
              decoration: InputDecoration(
                hintText: translate(AppStrings.sSearch),
                hintStyle: const TextStyle(color: AppColor.white),
              ),
            ),
          ),
        ],
      );

  get getTitle => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColor.white, shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.network(
                widget.arguments.categoryImage,
                width: 5.w,
              ),
            ),
          ),
          SizedBox(width: 1.h),
          Text(
            widget.arguments.categoryTitle,
            style: TextStyle(fontSize: 11.sp),
          ),
        ],
      );
}
