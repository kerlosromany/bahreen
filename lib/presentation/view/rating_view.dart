import 'package:elbahreen/business_logic/rate_cubit/rate_cubit.dart';
import 'package:elbahreen/constants/app_strings.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/presentation/router/app_router.dart';
import 'package:elbahreen/presentation/router/app_router_names.dart';
import 'package:elbahreen/presentation/styles/colors.dart';
import 'package:elbahreen/presentation/view/toast.dart';
import 'package:elbahreen/presentation/widget/default_button.dart';
import 'package:elbahreen/presentation/widget/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

class RatingView extends StatefulWidget {
  final int storeId;

  const RatingView({
    required this.storeId,
    Key? key,
  }) : super(key: key);

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  double rate_avg = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 30.h,
      margin: EdgeInsets.only(top: 35.h, bottom: 35.h, right: 20.w, left: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const DefaultText(text: "قم بتقييم المتجر"),
          RatingBar.builder(
            initialRating: rate_avg,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            unratedColor: AppColor.grey,
            textDirection: TextDirection.ltr,
            itemSize: 25.sp,
            glow: false,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star_outlined,
              color: AppColor.yellow,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                rate_avg = rating;
                print("raaaaaaaaaaaaaaaaaaate$rate_avg");
              });
            },
          ),
          SizedBox(
            height: 35,
            child: DefaultButton(
              text: "تقييم",
              press: () {
                print(widget.storeId);
                print(CacheHelper.getDataFromSharedPreference(key: "deviceId"));
                RateCubit.get(context).setStoreRate(
                  storeId: widget.storeId,
                  rate: rate_avg,
                 // context: context,
                  afterSuccess: () {
                    Navigator.pop(context);
                    showToast(translate(AppStrings.addRate));
                    print("succcccessssssssssssssssssssss"); 
                  },
                  afterFail: () {
                    RateCubit.get(context).updateStoreRate( 
                      storeId: widget.storeId,
                      rate: rate_avg,
                      afterSuccess: () {
                        Navigator.pop(context);
                        showToast(translate(AppStrings.addRate));
                        print("Faaaaaaaaaaaaaaaaaaaaaaaaaaail");
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
