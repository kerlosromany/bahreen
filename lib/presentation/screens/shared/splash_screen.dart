import 'package:elbahreen/constants/assets_manager.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/presentation/router/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future navigate({VoidCallback? afterSuccess}) async {
    await Future.delayed(const Duration(milliseconds: 3500), () {});
    afterSuccess!();
  }

  @override
  void initState() {
    navigate(afterSuccess: () {
      CacheHelper.getDataFromSharedPreference(key: "isConnected")
          ? Navigator.pushReplacementNamed(context, AppRouterNames.rHomeRoute)
          : Navigator.pushReplacementNamed(context, AppRouterNames.connection);
    });
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.8,
            child: Image.asset(
              AssetsManager.splashBg,
              fit: BoxFit.cover,
              width: 100.w,
              height: 100.h,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                AssetsManager.splashLogo,
                fit: BoxFit.fill,
                width: 60.w,
                height: 32.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
}
