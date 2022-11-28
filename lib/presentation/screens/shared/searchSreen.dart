import 'package:elbahreen/business_logic/global_cubit/global_cubit.dart';
import 'package:elbahreen/business_logic/global_cubit/global_state.dart';
import 'package:elbahreen/constants/app_strings.dart';
import 'package:elbahreen/presentation/router/app_router_names.dart';
import 'package:elbahreen/presentation/router/arguments/sub_category_argument.dart';
import 'package:elbahreen/presentation/view/category_view.dart';
import 'package:elbahreen/presentation/view/side_menu_view.dart';
import 'package:elbahreen/presentation/view/store_item.dart';
import 'package:elbahreen/presentation/widget/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';
import '../../router/arguments/stores_arguments.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(this.arguments, {Key? key}) : super(key: key);
  final StoresArguments arguments;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearch = false;
  final controller = ScrollController();
  int page = 0;
  bool finished = false;

  @override
  initState() {
    GlobalCubit.get(context).searchStore(page, widget.arguments.keyword, () {});
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        GlobalCubit.get(context)
            .searchStore(page, widget.arguments.keyword, () {});
        if (GlobalCubit.get(context).storeObject.length < 20) {
          setState(() {
            finished = true;
          });
        }
        setState(() {
          page = page + 1;
        });
      }
      print("page page" + page.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(AppStrings.sSearchResult),style: TextStyle(fontSize: 11.sp)),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
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
      body: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return const SizedBox();
          } else if (state is SearchEmptyState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 60.sp,
                  ),
                  DefaultText(
                    text: translate(
                      AppStrings.noSearchResult,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView(
            children: [
              GlobalCubit.get(context).categoryObject.isNotEmpty?
              SizedBox(
                width: 100.w,
                height: 5.h,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: DefaultText(text: translate(AppStrings.category)),
                ),
              ):const SizedBox(),
          GlobalCubit.get(context).categoryObject.isNotEmpty
          ? SizedBox(
                width: 100.w,
                height: 35.h,
                child: GridView.count(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 1.5.h),
                        crossAxisCount: 3,
                        children: List.generate(
                            GlobalCubit.get(context).categoryObject.length,
                            (index) => CategoryView(
                                  title: GlobalCubit.get(context)
                                      .categoryObject[index]['name'],
                                  imageUrl: GlobalCubit.get(context)
                                      .categoryObject[index]['image'],
                                  index: index,
                                  id: GlobalCubit.get(context)
                                      .categoryObject[index]['id'],
                                  route: AppRouterNames.rSubCategoryRoute,
                                  arguments: SubCategoryArguments(
                                    GlobalCubit.get(context)
                                        .categoryObject[index]['id'],
                                    GlobalCubit.get(context)
                                        .categoryObject[index]['name'],
                                    GlobalCubit.get(context)
                                        .categoryObject[index]['image'],
                                  ),
                                )),
                      )
                   ,
              ) :const SizedBox(),
              GlobalCubit.get(context).subCategoryObject.isNotEmpty
                  ? SizedBox(
                      width: 100.w,
                      height: 5.h,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: DefaultText(
                            text: translate(AppStrings.subCategory)),
                      ),
                    )
                  : const SizedBox(),
          GlobalCubit.get(context).subCategoryObject.isNotEmpty
          ? SizedBox(
                width: 100.w,
                height: 35.h,
                child: GridView.count(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 1.5.h),
                        crossAxisCount: 3,
                        children: List.generate(
                            GlobalCubit.get(context).subCategoryObject.length,
                            (index) => CategoryView(
                                  title: GlobalCubit.get(context)
                                      .subCategoryObject[index]['name'],
                                  imageUrl: GlobalCubit.get(context)
                                      .subCategoryObject[index]['image'],
                                  index: index,
                                  id: GlobalCubit.get(context)
                                      .subCategoryObject[index]['id'],
                                  route: AppRouterNames.rStoreRoute,
                                  arguments: StoresArguments(
                                    widget.arguments.categoryId,
                                    GlobalCubit.get(context)
                                        .subCategoryObject[index]['id'],
                                    GlobalCubit.get(context)
                                        .subCategoryObject[index]['name'],
                                    false,
                                    "",
                                  ),
                                )),
                      )
                    ,
              ): const SizedBox(),
              GlobalCubit.get(context).storeObject.isNotEmpty
                  ? SizedBox(
                      width: 100.w,
                      height: 5.h,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: DefaultText(text: translate(AppStrings.stores)),
                      ),
                    )
                  : const SizedBox(),
          GlobalCubit.get(context).storeObject.isNotEmpty
          ? SizedBox(
                width: 100.w,
                height: 35.h,
                child: ListView.builder(
                        controller: controller,
                        padding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 2.5.h),
                        itemCount: GlobalCubit.get(context).storeObject.length,
                        itemBuilder: (context, index) {
                          return StoresItem(
                            GlobalCubit.get(context).storeObject[index],
                            widget.arguments.subCategoryTitle,
                            widget.arguments.categoryId,
                            index,
                            "",
                          );
                        },
                      )
                    ,
              ): const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
