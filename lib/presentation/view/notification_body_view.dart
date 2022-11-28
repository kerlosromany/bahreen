import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../styles/colors.dart';
import 'notification_view.dart';

class NotificationBodyView extends StatelessWidget {
  const NotificationBodyView(this.notifications, {Key? key}) : super(key: key);
  final List<dynamic> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(2.h),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationView(notifications[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.5.h),
          child: const Divider(color: AppColor.red),
        );
      },
    );
  }
}
