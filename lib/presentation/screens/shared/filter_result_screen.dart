import 'package:elbahreen/business_logic/filter_cubit/filter_cubit.dart';
import 'package:elbahreen/business_logic/filter_cubit/filter_states.dart';
import 'package:elbahreen/constants/app_strings.dart';
import 'package:elbahreen/presentation/router/arguments/filter_arguments.dart';
import 'package:elbahreen/presentation/view/loading_view.dart';
import 'package:elbahreen/presentation/view/side_menu_view.dart';
import 'package:elbahreen/presentation/view/store_item.dart';
import 'package:elbahreen/presentation/widget/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

class FilterResultScreen extends StatefulWidget {
  final FilterArguments filterArguments;

  const FilterResultScreen({required this.filterArguments, Key? key})
      : super(key: key);

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  bool isSearch = false;
  final controller = ScrollController();
  int page = 0;
  bool finished = false;
  List<dynamic> stores = [];

  @override
  initState() {
    FilterCubit.get(context).filter(
      afterSuccess: () {
        if (FilterCubit.get(context).filterResult.length < 20) {
          setState(() {
            finished = true;
          });
        }
      },
      district: widget.filterArguments.districtId!,
      subCategoryId: widget.filterArguments.subCategoryId!,
      page: page,
    );
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        FilterCubit.get(context).filter(
            afterSuccess: () {}, district: 0, subCategoryId: 0, page: page);
        if (FilterCubit.get(context).filterResponse!.stores.length < 20) {
          setState(() {
            finished = true;
          });
        }
        setState(() {
          page = page + 1;
        });
      }
      print("page page" + page.toString());
      print(
          'lingth ' + FilterCubit.get(context).filterResult.length.toString());
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
        title: Text(translate(AppStrings.sSearchResult),
            style: TextStyle(fontSize: 11.sp)),
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
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          if (state is LoadingFilterState) {
            print("State is LoadingFilterState");
            return ListView.builder(itemBuilder: (context, index) {
              return LoadingView(
                height: 10.h,
                width: 90.w,
              );
            });
          }
          if (state is EmptyFilterState) {
            print("State is EmptyFilterState");
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
          return ListView.builder(
            //controller: controller,
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.h),
            itemCount: FilterCubit.get(context).filterResult.length + 1,
            itemBuilder: (context, index) {
              return index < FilterCubit.get(context).filterResult.length
                  ? StoresItem(
                      FilterCubit.get(context).filterResult[index],
                      widget.filterArguments.subCategory!,
                      widget.filterArguments.categoryId,
                      index,
                      "",
                    )
                  : finished
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
    );
  }
}
