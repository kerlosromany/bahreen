// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../constants/constant_mehods.dart';
// import '../../data/models/branch_object.dart';
// import '../view/branch_info_view.dart';
// import '../styles/colors.dart';
// import '../styles/styles.dart';
//
// class BranchDetailsView extends StatelessWidget {
//   const BranchDetailsView(this.branch, {Key? key}) : super(key: key);
//
//   final BranchObject branch;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
//       decoration: maniBocDecoration,
//       child: Column(
//         children: [
//           Container(
//             width: 100.h,
//             padding: EdgeInsets.all(1.8.h),
//             decoration: maniBocDecoration.copyWith(
//               color: AppColor.red,
//               borderRadius: BorderRadius.circular(.5.h),
//             ),
//             child: Text(
//               branch.name,
//               style: TextStyle(color: AppColor.white, fontSize: 12.sp),
//               textAlign: TextAlign.start,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
//             height: generateNoOfBranchContact(branch).length * 5.8.h,
//             child: Column(
//               children: [
//                 ...generateNoOfBranchContact(branch)
//                     .entries
//                     .map((branch) =>
//                         BranchInfo(iconName: branch.key, details: branch.value))
//                     .toList(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
// }
