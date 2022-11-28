import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';
import '../widget/default_text.dart';
import '../widget/drop_down_menu_item.dart';

class FilterComponentView extends StatelessWidget {
  const FilterComponentView(
      {required this.text,
      required this.value,
      required this.items,
      required this.onChanged,
      this.icon,
      Key? key})
      : super(key: key);

  final String text;
  final String? value;
  final List<dynamic> items;
  final Function onChanged;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: .3.h),
        padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: .2.h),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: value,
            isExpanded: true,
            elevation: 2,
            hint: Container(
              alignment: Alignment.center,
              child: DefaultText(text: text, size: 14.sp),
            ),
            icon: Icon(icon ?? Icons.arrow_drop_down, color: AppColor.red),
            alignment: Alignment.centerLeft,
            items: items.map((item) => buildMenuItem(item)).toList(),
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ),
      ),
    );
  }
}
