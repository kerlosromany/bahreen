import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyCustomContainer extends StatelessWidget {
  double width;
  double height;
  Widget? widget;
  AlignmentGeometry? alignment;
  Color? color;
  BoxShape? boxShape;
  double? borderWidth;
  MyCustomContainer({
    Key? key,
    required this.widget,
    required this.height,
    required this.width,
    this.alignment,
    this.color,
    this.boxShape,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: borderWidth ?? 1.5, color: color ?? Colors.red),
      ),
      child: widget,
    );
  }
}
