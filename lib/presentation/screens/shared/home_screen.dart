import 'package:carousel_slider/carousel_slider.dart';
import 'package:elbahreen/business_logic/global_cubit/global_state.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/presentation/router/app_router_names.dart';
import 'package:elbahreen/presentation/router/arguments/stores_arguments.dart';
import 'package:elbahreen/presentation/router/arguments/sub_category_argument.dart';
import 'package:elbahreen/presentation/view/category_view.dart';
import 'package:elbahreen/presentation/widget/my_custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../constants/app_strings.dart';
import '../../view/side_menu_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  final controller = ScrollController();
  TextEditingController searchController = TextEditingController();
  int page = 1;

  //List<dynamic> categories = [];

  @override
  initState() {
    //categories = GlobalCubit.get(context).categoriesList;
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        GlobalCubit.get(context).getCategories(page: page);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(translate(AppStrings.sHome),
                      style: TextStyle(fontSize: 11.sp)),
                ],
              ),
        leading: Builder(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Icon(Icons.more_vert),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouterNames.favorite);
                  },
                  child: const Icon(Icons.favorite_outlined),
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                searchController.text = '';
                setState(() {
                  isSearch = !isSearch;
                });
              },
              icon: Icon(isSearch ? Icons.cancel : Icons.search)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                isSearch
                    ? {
                        Navigator.pushNamed(context, AppRouterNames.rSearch,
                            arguments: StoresArguments(
                                1, 1, "", true, searchController.text)),
                      }
                    : {
                        CacheHelper.getDataFromSharedPreference(
                                    key: 'language') ==
                                "ar"
                            ? GlobalCubit.get(context).toEnglish(
                                afterSuccess: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRouterNames.rSplashRoute);
                              })
                            : GlobalCubit.get(context).toArabic(
                                afterSuccess: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRouterNames.rSplashRoute);
                              }),
                      };
              },
              child: isSearch
                  ? const Icon(Icons.search)
                  : Padding(
                      padding: EdgeInsets.only(
                        top: CacheHelper.getDataFromSharedPreference(
                                    key: 'language') ==
                                "ar"
                            ? 8
                            : 0,
                      ),
                      child: SizedBox(
                        width: 11.w,
                        child: Center(
                          child: Text(
                            CacheHelper.getDataFromSharedPreference(
                                        key: 'language') ==
                                    "ar"
                                ? "En"
                                : "ع",
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      drawer: const SideMenuView(),
      drawerEnableOpenDragGesture: false,
      body: Column(
        children: [
          BlocBuilder<GlobalCubit, GlobalState>(
            builder: (context, state) {
              if (GlobalCubit.get(context).adsResponse!.ads.isEmpty) {
                return const SizedBox();
              }
              return CarouselSlider.builder(
                itemCount: GlobalCubit.get(context).adsResponse!.ads.length,
                itemBuilder: (context, position, realIndex) {
                  return Padding(
                    padding: EdgeInsets.only(top: 0.8.h),
                    child: Image.network(GlobalCubit.get(context)
                        .adsResponse!
                        .ads[position]["image"]),
                    //Image.asset('assets/images/ad.png'),
                  );
                },
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  height: 20.h,
                  enlargeCenterPage: true,
                ),
              );
            },
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRouterNames.traderJoinRoute);
            },
            child: MyCustomContainer(
              width: 0.26 * screenWidth,
              height: 0.06 * screenHeight,
              widget: FittedBox(
                child: Text(
                  CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'ar'
                      ? "انضم كتاجر"
                      : "Join as a trader",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            child: BlocBuilder<GlobalCubit, GlobalState>(
              builder: (context, state) {
                return GridView.count(
                  controller: controller,
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
                  crossAxisCount: 3,
                  children: List.generate(
                    GlobalCubit.get(context).categoriesList.length + 1,
                    (index) =>
                        index < GlobalCubit.get(context).categoriesList.length
                            ? CategoryView(
                                title: GlobalCubit.get(context)
                                    .categoriesList[index]['name'],
                                imageUrl: GlobalCubit.get(context)
                                    .categoriesList[index]['image'],
                                index: index,
                                id: GlobalCubit.get(context)
                                    .categoriesList[index]['id'],
                                route: AppRouterNames.rSubCategoryRoute,
                                arguments: SubCategoryArguments(
                                  GlobalCubit.get(context).categoriesList[index]
                                      ['id'],
                                  GlobalCubit.get(context).categoriesList[index]
                                      ['name'],
                                  GlobalCubit.get(context).categoriesList[index]
                                      ['image'],
                                ),
                              )
                            : GlobalCubit.get(context).finished
                                ? const SizedBox()
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
