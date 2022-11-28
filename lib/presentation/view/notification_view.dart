import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class NotificationView extends StatelessWidget {
  final dynamic notificationModel;

  const NotificationView(this.notificationModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:notificationModel['is_seen'] ?AppColor.white:AppColor.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: EdgeInsets.all(1.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 7.h,
              width: 7.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.red, width: 2)),
              child: Image.asset('assets/images/nn.png'),
            ),
            SizedBox(width: 1.2.h),
            Expanded(
              flex: 5,
              child: Text(
                notificationModel['content'],
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
