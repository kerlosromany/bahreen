import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';
import 'default_text.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color? color;

  const DefaultButton(
      {required this.text, required this.press, this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 6.5.h,
        color: color ?? AppColor.red,
        onPressed: () => press(),
        child: DefaultText(
            text: text,
            color: AppColor.white,
            size: 14.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
