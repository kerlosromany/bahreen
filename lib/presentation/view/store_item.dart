import 'package:elbahreen/business_logic/favourite_cubit/favourite_cubit.dart';
import 'package:elbahreen/business_logic/rate_cubit/rate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../router/app_router_names.dart';
import '../router/arguments/store_details_arguments.dart';
import '../styles/styles.dart';
import '../styles/colors.dart';
import '../widget/default_text.dart';

class StoresItem extends StatefulWidget {
  StoresItem(
      this.store, this.subCategoryTitle, this.categoryId, this.index, this.rate,
      {this.isSelected = false, Key? key})
      : super(key: key);

  final dynamic store;
  final String subCategoryTitle;
  final int categoryId;
  final int index;
  bool isSelected;
  String? rate;

  @override
  State<StoresItem> createState() => _StoresItemState();
}

class _StoresItemState extends State<StoresItem> {
  @override
  initState() {
    // for (int i = 0; i < widget.store['branches'].length; i++) {
    //   branches.add(widget.store['branches'][i]['name']);
    // }
    widget.isSelected = widget.store['fav'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  {
         Navigator.pushNamed(
          context,
          AppRouterNames.rStoreDetailsRoute,
          arguments: StoreDetailsArguments(
            widget.categoryId,
            widget.store,
            widget.store['branches'] ?? [],
            widget.index,
            widget.rate as String,
          ),
        ) ;
        
      },
      child: Card(
        elevation: 4,
        color: AppColor.white,
        margin: EdgeInsets.only(bottom: 1.2.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          decoration: defBoxDecoration,
          padding: EdgeInsets.all(1.5.h),
          child: Row(
            children: [
              FittedBox(
                child: Container(
                  width: 10.h,
                  height: 10.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.store['image'] ??
                            "https://519.magdsofteg.xyz/uploads/Category/7qvc3V1PFjNZazqAePhxlFHWmp1Rny1663753343.jpg",
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
              ),
              SizedBox(width: 1.5.h),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: DefaultText(
                            text: widget.store['name'],
                            size: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.5.h),
                          child: DefaultText(
                              text: widget.subCategoryTitle,
                              color: AppColor.red),
                        ),
                        // Text(branches.join(' - '),
                        //     style: getRegularStyle(color: AppColor.darkGrey),
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis)
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            if (widget.isSelected) {
                              setState(() {
                                widget.isSelected = false;
                              });
                              FavouriteCubit.get(context)
                                  .deleteStoreToFavourite(
                                storeId: widget.store['id'],
                                afterSuccess: () {},
                                afterFail: () {},
                              );
                            } else {
                              setState(() {
                                widget.isSelected = true;
                              });
                              FavouriteCubit.get(context).addStoreToFavourite(
                                storeId: widget.store['id'],
                                afterSuccess: () {},
                                afterFail: () {},
                                subCategoryTitle: widget.subCategoryTitle,
                              );
                            }
                          },
                          child: widget.isSelected
                              ? const Icon(
                                  Icons.favorite_outlined,
                                  color: AppColor.red,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                  color: AppColor.red,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
