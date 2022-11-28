// import 'package:elbahreen/business_logic/global_cubit/global_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../router/app_router_names.dart';
// import '../router/arguments/sub_category_argument.dart';
// import 'category_view.dart';
//
// class HomeBodyView extends StatefulWidget {
//   const HomeBodyView(this.categories, {Key? key}) : super(key: key);
//   final List<dynamic> categories;
//
//   @override
//   State<HomeBodyView> createState() => _HomeBodyViewState();
// }
//
// class _HomeBodyViewState extends State<HomeBodyView> {
// final controller = ScrollController();
// int page = 0;
// @override
//   initState(){
//   controller.addListener(() {
//     if(controller.position.maxScrollExtent == controller.offset){
//       GlobalCubit.get(context).getCategories(page: page);
//       setState((){
//         page =page +1;
//         print(page);
//       });
//     }
//   });
//   super.initState();
// }
//
// @override
//   void dispose(){
//   controller.dispose();
//   super.dispose();
// }
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       controller: controller,
//       padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
//       crossAxisCount: 3,
//       children: List.generate(
//         widget.categories.length + 1,
//         (index) => index < widget.categories.length
//             ? CategoryView(
//                 title: widget.categories[index]['name'],
//                 imageUrl: widget.categories[index]['image'],
//                 index: index,
//                 route: AppRouterNames.rSubCategoryRoute,
//                 arguments: SubCategoryArguments(
//                   widget.categories[index]['id'],
//                   widget.categories[index]['name'],
//                   widget.categories[index]['image'],
//                 ),
//               )
//             : const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 32),
//           child: Center(
//             child: CircularProgressIndicator(),
//           ),
//               ),
//       ),
//     );
//   }
// }
