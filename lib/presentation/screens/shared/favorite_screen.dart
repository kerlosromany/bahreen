import 'package:elbahreen/business_logic/favourite_cubit/favourite_cubit.dart';
import 'package:elbahreen/constants/app_strings.dart';
import 'package:elbahreen/presentation/view/loading_view.dart';
import 'package:elbahreen/presentation/view/side_menu_view.dart';
import 'package:elbahreen/presentation/view/store_item.dart';
import 'package:elbahreen/presentation/widget/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  final controller = ScrollController();
  int page = 0;
  List<dynamic> stores = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCubit()..getFavouriteStores(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("المفضلة", style: TextStyle(fontSize: 11.sp)),
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
        body: BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
            if (state is! FavouriteSuccess && state is! FavouriteEmpty) {
              return ListView.builder(itemBuilder: (context, index) {
                return LoadingView(
                  height: 10.h,
                  width: 90.w,
                );
              });
            } else if (state is FavouriteEmpty) {
              return Center(
                child: DefaultText(
                  text: translate(AppStrings.noDataFound),
                ),
              );
            }
            return ListView.builder(
              controller: controller,
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.h),
              itemCount: FavouriteCubit.get(context).stores.length,
              itemBuilder: (context, index) { 
                print("${FavouriteCubit.get(context).stores[index]}");
                return index < FavouriteCubit.get(context).stores.length
                    ? StoresItem(
                        FavouriteCubit.get(context).stores[index],
                        "${FavouriteCubit.get(context).stores[index]['subCategoryTitle']}", 
                        
                        5,
                        index,
                        "${FavouriteCubit.get(context).stores[index]['rate']}", 
                        isSelected: true,
                      )
                    : FavouriteCubit.get(context).finished
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
