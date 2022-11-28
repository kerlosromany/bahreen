import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class BranchInfo extends StatelessWidget {
  final String iconName;
  final String details;
  final VoidCallback onTap;

  const BranchInfo({
    Key? key,
    required this.iconName,
    required this.details,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: .3.h),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 2.4.h,
                    height: 2.4.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(iconName)),
                    )),
                SizedBox(width: 1.4.h),
                SizedBox(
                  width: 70.w,
                  child: Text(details,
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: .4.h, vertical: .1.h),
                child: const Divider(color: AppColor.grey),
              ),
          ],
        ),
      ),
    );
  }
}
