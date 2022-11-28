import 'package:elbahreen/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/styles.dart';

class CategoryView extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final int index;
  final int id;
  final String route;
  final Object arguments;

  const CategoryView(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.index,
      required this.route,
      required this.id,
      required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //SubCategoryCubit.get(context).getSubCategories(categoryId: id, page: 0);
        Navigator.pushNamed(context, route, arguments: arguments);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: .75.h, vertical: 1.h),
        height: 10.h,
        width: 10.h,
        decoration: maniBocDecoration.copyWith(
          borderRadius: BorderRadius.circular(1.h),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            imageUrl != null
                ? SizedBox(
                    height: 5.h,
                    width: 5.h,
                    child: Image.network(imageUrl!, fit: BoxFit.cover),
                  )
                : SizedBox(
                    height: 5.h,
                    width: 4.h,
                    child: Image.asset(AssetsManager.placeholder,
                        fit: BoxFit.cover),
                  ),
            SizedBox(height: 1.h),
            Text(title, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
