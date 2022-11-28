import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BranchInfo extends StatelessWidget {
  final String iconName;
  final String detailTitle;

  const BranchInfo({
    Key? key,
    required this.iconName,
    required this.detailTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          // svg,
          Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                // color: Colors.yellow,
                image: DecorationImage(
                  image: AssetImage(iconName),
                ),
              )),
          const Spacer(
            flex: 1,
          ),
          Text(detailTitle),
          const Spacer(
            flex: 15,
          ),
        ],
      ),
    );
  }
}
