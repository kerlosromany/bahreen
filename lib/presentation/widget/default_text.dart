import 'package:elbahreen/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;

  const DefaultText({
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColor.black,
        fontSize: size ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1,
    );
  }
}
