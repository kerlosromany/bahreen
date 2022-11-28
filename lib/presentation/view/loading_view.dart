import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../styles/colors.dart';

class LoadingView extends StatelessWidget {
  final double width;
  final double height;

  const LoadingView({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[200]!,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColor.grey,
            ),
          ),
        ),
      ),
    );
  }
}
