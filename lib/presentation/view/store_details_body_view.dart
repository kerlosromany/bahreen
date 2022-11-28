import 'package:elbahreen/business_logic/global_cubit/global_cubit.dart';
import 'package:elbahreen/business_logic/global_cubit/global_state.dart';
import 'package:elbahreen/business_logic/rate_cubit/rate_cubit.dart';
import 'package:elbahreen/business_logic/store_cubit/stores_cubit.dart';
import 'package:elbahreen/business_logic/store_cubit/stores_state.dart';
import 'package:elbahreen/business_logic/store_details_cubit/store_details_state.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/presentation/styles/styles.dart';
import 'package:elbahreen/presentation/view/branch_info_view.dart';
import 'package:elbahreen/presentation/view/rating_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:elbahreen/presentation/styles/colors.dart';
import 'package:elbahreen/business_logic/store_details_cubit/store_details_cubit.dart';

class StoreDetailsBody extends StatefulWidget {
  const StoreDetailsBody({
    Key? key,
    required this.store,
    required this.categoryId,
    required this.branches,
    required this.rate,
  }) : super(key: key);
  final dynamic store;
  final List<dynamic> branches;
  final int categoryId;
  final String rate;

  @override
  State<StoreDetailsBody> createState() => _StoreDetailsBodyState();
}

class _StoreDetailsBodyState extends State<StoreDetailsBody> {
  Future<void> _launchUrl(String _url) async {
    await launch(_url, universalLinksOnly: false);
    // if (await canLaunch(_url)) {
    //   await launch(_url,universalLinksOnly: false);
    // } else {
    //   showToast("لا يمكن فتح هذا الرابط");
    //   throw 'Could not launch $_url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    // print("**********************************${widget.store['avg_rate']}");
    // print(
    //     "**********************************${RateCubit.get(context).updatedRate}");
    print("////////${widget.rate}");

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(2.h),
            width: 20.h,
            height: 20.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  widget.store['image'] ??
                      "https://519.magdsofteg.xyz/uploads/Category/7qvc3V1PFjNZazqAePhxlFHWmp1Rny1663753343.png",
                ),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    offset: Offset(0.0, 0.5.h),
                    blurRadius: 2.0),
              ],
            ),
          ),
          Text(widget.store['name'], style: TextStyle(fontSize: 24.sp)),
          const SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // BlocBuilder<RateCubit, RateState>(
              //   builder: ((context, state) => Text(
              //         "( ${widget.rate == "" ? RateCubit.get(context).updatedRate == "0.0" ? widget.store['avg_rate'] : double.parse(RateCubit.get(context).updatedRate).toStringAsFixed(2) : double.parse(widget.rate).toStringAsFixed(2)} )",
              //         style: TextStyle(fontSize: 12.sp, color: AppColor.grey),
              //       )),
              // ),

              // BlocBuilder<RateCubit, RateState>(
              //   builder: ((context, state) => Text(
              //         "( ${RateCubit.get(context).updatedRate == "0.0" ? widget.store['avg_rate'] : double.parse(RateCubit.get(context).updatedRate).toStringAsFixed(2)} )",
              //         style: TextStyle(fontSize: 12.sp, color: AppColor.grey),
              //       )),
              // ),

              // BlocBuilder<StoreCubit, StoreState>(
              //   builder: ((context, state) => Text(
              //         "( ${StoreCubit.get(context).stores.forEach((element) {
              //           element
              //         })}  )",
              //         style: TextStyle(fontSize: 12.sp, color: AppColor.grey),
              //       )),
              // ),

              BlocBuilder<RateCubit, RateState>(
                builder: ((context, state) => Text(
                      "( ${CacheHelper.getDataFromSharedPreference(key: "${widget.store['id']}") ?? widget.store['avg_rate'] ?? widget.rate}  )",
                      style: TextStyle(fontSize: 12.sp, color: AppColor.grey),
                    )),
              ),
              // if (CacheHelper.getDataFromSharedPreference(
              //         key: "${widget.store['id']}") ==
              //     null)
              //   Text(
              //     "( ${widget.rate}  )",
              //     style: TextStyle(fontSize: 12.sp, color: AppColor.grey),
              //   ),
              // Text(
              //     "( ${widget.store['avg_rate'] ?? "0.0"} )",
              //     style: TextStyle(fontSize: 12.sp, color: AppColor.grey),
              //   ),

              // BlocBuilder<GlobalCubit, GlobalState>(
              //   builder: ((context, state) {
              //     List<dynamic> categories = [];
              //     categories = GlobalCubit.get(context).categoriesList;
              //     return Text(
              //         "( ${store['avg_rate'] ?? "0.0"} )",
              //         style: TextStyle(fontSize: 12.sp, color: AppColor.grey),
              //       );
              //   }),
              // ),

              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return RatingView(
                        storeId: widget.store['id'],
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.star_rate_rounded,
                  color: AppColor.yellow,
                ),
              )
            ],
          ),
          BlocConsumer<StoreDetailsCubit, StoreDetailsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  StoreDetailsCubit.get(context).subCategoryName ?? "",
                  style: TextStyle(
                      color: AppColor.red,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300),
                ),
              );
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.branches.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                decoration: maniBocDecoration,
                child: Column(
                  children: [
                    Container(
                      width: 100.h,
                      padding: EdgeInsets.all(1.8.h),
                      decoration: maniBocDecoration.copyWith(
                        color: AppColor.red,
                        borderRadius: BorderRadius.circular(.5.h),
                      ),
                      child: Text(
                        widget.branches[index]['name'],
                        style:
                            TextStyle(color: AppColor.white, fontSize: 12.sp),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
                      height: 35.h,
                      child: Column(
                        children: [
                          BranchInfo(
                            iconName: "assets/icons/phone.png",
                            details: widget.branches[index]['phone'] ?? "",
                            onTap: () {
                              _launchUrl(
                                'tel:${widget.branches[index]['phone']}',
                              );
                            },
                          ),
                          BranchInfo(
                            iconName: "assets/icons/whatsapp.png",
                            details:
                                widget.branches[index]['whatsappLink'] ?? "",
                            onTap: () {
                              if (widget.branches[index]['whatsappLink']
                                  .toString()
                                  .contains("973")) {
                                _launchUrl(
                                  "https://wa.me/+${widget.branches[index]['whatsappLink']}",
                                );
                              } else {
                                // var re = RegExp(r'(?<=973)(.*)');
                                // var match =
                                // re.firstMatch(branches[index]['whatsappLink']);
                                // print("https://wa.me/+973${match!.group(0)}");
                                _launchUrl(
                                  "https://wa.me/+973${widget.branches[index]['whatsappLink']}",
                                );
                              }
                            },
                          ),
                          BranchInfo(
                            iconName: "assets/icons/instagram.png",
                            details: widget.branches[index]['instagram_user'] ??
                                "Instagram",
                            onTap: () {
                              _launchUrl(
                                "${widget.branches[index]['instaLink']}",
                              );
                            },
                          ),
                          BranchInfo(
                            iconName: "assets/icons/placeholder.png",
                            details: widget.branches[index]['district'] != null
                                ? widget.branches[index]['district']['name']
                                : "Location",
                            onTap: () {},
                          ),
                          BranchInfo(
                            iconName: "assets/icons/ios.png",
                            details: "Apple Map",
                            onTap: () {
                              _launchUrl(
                                'https://maps.apple.com/?q=${widget.branches[index]['latitude']},${widget.branches[index]['longitude']}',
                              );
                            },
                          ),
                          BranchInfo(
                            iconName: "assets/icons/map.png",
                            details: widget.branches[index]['address_text'] ??
                                "Location",
                            onTap: () {
                              var re = RegExp(r'(?<=http)(.*)');
                              var match = re.firstMatch(
                                  widget.branches[index]['address']);
                              print('http${match!.group(0)}');
                              _launchUrl(
                                'http${match.group(0)}',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
