import 'package:elbahreen/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashBackgroundView extends StatelessWidget {
  const SplashBackgroundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Image.asset(AssetsManager.splashBg,
          fit: BoxFit.cover, width: 100.w, height: 100.h),
    );
  }
}
