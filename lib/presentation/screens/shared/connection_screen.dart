import 'package:elbahreen/presentation/widget/default_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/connection.png'),
          ),
          const SizedBox(
            height: 30,
          ),
          DefaultText(
            text: "لايوجد إتصال بالإنترنت",
            size: 15.sp,
          ),
          const SizedBox(
            height: 30,
          ),
          // DefaultButton(
          //     text: "إعادة المحاولة", press: (){
          //       GlobalCubit()..checkConnection()..getFirstUser()..getAds()..getCategories(page: 0);
          //   Navigator.pushReplacementNamed(context, AppRouterNames.rSplashRoute);
          // })
        ],
      ),
    );
  }
}
