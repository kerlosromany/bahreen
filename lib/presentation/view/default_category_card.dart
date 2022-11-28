import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DefaultCategoryCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String routeName;
  final String screenTitle;
  final dynamic args;
  final bool isHome;

  const DefaultCategoryCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.routeName,
    required this.screenTitle,
    required this.args,
    required this.isHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (!isHome) {
        // } else {
        //   Navigator.pushNamed(context, routeName);
        // }
        Navigator.pushNamed(context, routeName, arguments: args);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        height: 20.w,
        width: 20.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.w),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 4.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            imageUrl != null
                ? Image.network(
                    imageUrl!,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      "assets/images/placeholder.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(
              height: 5.0,
            ),
            Text(title, style: TextStyle(fontSize: 12.sp))
          ],
        ),
      ),
    );
  }
}
