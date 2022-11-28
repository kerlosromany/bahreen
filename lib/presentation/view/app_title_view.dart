import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_strings.dart';
import '../styles/colors.dart';
import '../widget/default_text.dart';

class AppTitleView extends StatelessWidget {
  const AppTitleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultText(
              text: translate(AppStrings.sBahrin),
              color: AppColor.red,
                size: 32.sp,
              fontWeight: FontWeight.bold),
          DefaultText(
              text: translate(AppStrings.sSearch),
              color: AppColor.grey,
              size: 32.sp,
              fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
