import 'package:elbahreen/presentation/view/side_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/rate_cubit/rate_cubit.dart';
import '../../router/arguments/store_details_arguments.dart';
import '../../view/store_details_body_view.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen(this.arguments, {Key? key}) : super(key: key);

  final StoreDetailsArguments arguments;

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    print("StoreDetailsScreen came");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments.store['name'],
            style: TextStyle(fontSize: 11.sp)),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              //RateCubit.get(context).updatedRate = "0.0";
              Navigator.of(context).pop("0.0");

              
              //RateCubit.get(context).updatedRate = "0.0";
            }),
        actions: [ 
          Builder(
            builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => Scaffold.of(context).openDrawer());
            },
          ),
        ],
      ),
      drawer: const SideMenuView(),
      drawerEnableOpenDragGesture: false,
      body: StoreDetailsBody(
        categoryId: widget.arguments.categoryId,
        store: widget.arguments.store,
        branches: widget.arguments.branches, 
        rate: widget.arguments.rate,
      ),
    );
  }
}
