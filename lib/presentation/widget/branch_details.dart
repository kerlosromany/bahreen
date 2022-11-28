// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../constants/constants.dart';
// import '../../data/models/branch_object.dart';
// import '../styles/colors.dart';
// import 'branch_info.dart';
//
// class BranchDetails extends StatelessWidget {
//   final BranchObject branch;
//
//   BranchDetails({
//     Key? key,
//     required this.branch,
//   }) : super(key: key);
//
//   late List<String> titles = [
//     branch.whatsappLink ?? '',
//     branch.instaLink ?? '',
//     branch.phone ?? '',
//     branch.address,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(6.w),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3), // changes position of shadow
//           ),
//         ],
//         color: AppColor.white,
//         borderRadius: BorderRadius.circular(3.w),
//       ),
//       child: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(bottom: 1.5.h),
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: const Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//               color: AppColor.red,
//               borderRadius: BorderRadius.circular(3.w),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   branch.name,
//                   style: TextStyle(color: AppColor.white, fontSize: 14.sp),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 4 * 5.h,
//             child: ListView.separated(
//               physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (BuildContext context, int index) {
//                 return BranchInfo(
//                   iconName: myIcons[index],
//                   detailTitle: titles[index],
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) => Divider(
//                 color: Colors.grey,
//                 indent: 7.w,
//                 endIndent: 7.w,
//               ),
//               itemCount: 4,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
