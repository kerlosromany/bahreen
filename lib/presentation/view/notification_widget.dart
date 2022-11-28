import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationWidget extends StatelessWidget {
  final String notificationText;
  final String? notificationImage;

  const NotificationWidget({
    required this.notificationText,
    required this.notificationImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      padding: EdgeInsets.only(top: 7.w, right: 8.w, left: 8.w, bottom: 3.w),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 3.w),
            width: 25.w,
            height: 25.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.w),
              child: notificationImage == null
                  ? Image.asset(
                      "assets/images/placeholder.jpg",
                      fit: BoxFit.fill,
                    )
                  : Image.network(notificationImage!),
            ),
          ),
          Expanded(
            child: Text(
              notificationText,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Image(image: Svg(notificationImage)),
        ],
      ),
    );
  }
}
