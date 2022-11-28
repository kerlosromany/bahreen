import 'package:elbahreen/presentation/styles/colors.dart';
import 'package:elbahreen/presentation/widget/default_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

customError() {
  ErrorWidget.builder = (FlutterErrorDetails error) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/error.png'),
            ),
            const SizedBox(
              height: 30,
            ),
            DefaultText(
              text: error.toString(),
              size: 12.sp,
            ),
          ],
        ),
      ),
    );
  };
}
