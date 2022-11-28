import 'package:elbahreen/business_logic/global_cubit/global_cubit.dart';
import 'package:elbahreen/constants/app_strings.dart';
import 'package:elbahreen/presentation/router/arguments/filter_arguments.dart';
import 'package:elbahreen/presentation/styles/colors.dart';
import 'package:elbahreen/presentation/view/loading_view.dart';
import 'package:elbahreen/presentation/view/side_menu_view.dart';
import 'package:elbahreen/presentation/view/store_item.dart';
import 'package:elbahreen/presentation/widget/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/rate_cubit/rate_cubit.dart';
import '../../../business_logic/store_cubit/stores_cubit.dart';
import '../../../business_logic/store_cubit/stores_state.dart';
import '../../router/app_router_names.dart';
import '../../router/arguments/stores_arguments.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen(this.arguments, {Key? key}) : super(key: key);
  final StoresArguments arguments;

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final controller = ScrollController();
  int page = 0;
  List<dynamic> stores = [];

  @override
  initState() {
    controller.addListener(() {
      if (widget.arguments.search) {
        if (controller.position.maxScrollExtent == controller.offset) {
          GlobalCubit.get(context)
              .searchStore(page, widget.arguments.keyword, () {});
          if (GlobalCubit.get(context).storeObject.length < 20) {}
          setState(() {
            page = page + 1;
          });
        }
      } else {
        if (controller.position.maxScrollExtent == controller.offset) {
          StoreCubit.get(context).getStores(
              subCategoryId: widget.arguments.subCategoryId, page: page);
          if (StoreCubit.get(context).storesResponse!.stores.length < 20) {}
          setState(() {
            page = page + 1;
          });
        }
      }

      print("page page" + page.toString());
    });

    // setState(() {
    //   print("this stooooooooooooooooooore screen page");
    //   print(RateCubit.get(context).updatedRate);
    //   RateCubit.get(context).updatedRate = "0.0";
    // });

///////////////////////

    ////////////
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   print("this stooooooooooooooooooore screen page");
    //   print(RateCubit.get(context).updatedRate);
    //   RateCubit.get(context).updatedRate = "0.0";
    // });
    return BlocProvider(
      create: (context) {
        return StoreCubit()
          ..getStores(
            subCategoryId: widget.arguments.subCategoryId,
            page: page,
          );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.arguments.subCategoryTitle,
              style: TextStyle(fontSize: 11.sp)),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouterNames.rFilterRoute,
                  arguments: FilterArguments(
                    widget.arguments.categoryId,
                    subCategory: widget.arguments.subCategoryTitle,
                    subCategoryId: widget.arguments.subCategoryId,
                    isNotEmpty: false,
                  ),
                );
              },
              child: Image.asset(
                'assets/icons/filter.png',
                height: 22,
                width: 22,
                color: AppColor.white,
              ),
            ),
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
        body: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            if (state is! SuccessGetStoresState && state is! EmptyStoresState) {
              return ListView.builder(itemBuilder: (context, index) {
                return LoadingView(
                  height: 10.h,
                  width: 90.w,
                );
              });
            } else if (state is EmptyStoresState) {
              return Center(
                child: DefaultText(
                  text: translate(AppStrings.noDataFound),
                ),
              );
            }
            return ListView.builder(
              controller: controller,
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.h),
              itemCount: StoreCubit.get(context).stores.length + 1,
              itemBuilder: (context, index) {
                return index < StoreCubit.get(context).stores.length
                    ? StoresItem(
                        StoreCubit.get(context).stores[index],
                        widget.arguments.subCategoryTitle,
                        widget.arguments.categoryId,
                        index,
                        "",
                      )
                    : StoreCubit.get(context).finished
                        ? const SizedBox()
                        : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
              },
            );
          },
        ),
      ),
    );
  }
}
