import 'dart:async';

import 'package:elbahreen/business_logic/global_cubit/global_cubit.dart';
import 'package:elbahreen/business_logic/global_cubit/global_state.dart';
import 'package:elbahreen/constants/constants.dart';
import 'package:elbahreen/presentation/view/side_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/app_strings.dart';

class WhoAreWeScreen extends StatelessWidget {
  WhoAreWeScreen({Key? key}) : super(key: key);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(AppStrings.sWhoAreWe),style: TextStyle(fontSize: 11.sp)),
        leading: Builder(
          builder: (context) {
            return IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => Scaffold.of(context).openDrawer());
          },
        ),
      ),
      drawer: const SideMenuView(),
      drawerEnableOpenDragGesture: false,
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: BlocBuilder<GlobalCubit, GlobalState>(
          builder: (context, state) {
            if(url == ""){
              return const SizedBox();
            }
            return WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            );
          },
        ),
      ),
      // body: Container(
      //   padding: EdgeInsets.all(2.h) + EdgeInsets.only(top: 1.h),
      //   height: 100.h,
      //   width: 100.w,
      //   child: BlocBuilder<AboutUsCubit, AboutUsState>(
      //     builder: (context, state) {
      //       if (state is! SuccessGetAboutUsState) {
      //         return const SizedBox();
      //       }
      //       return SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             Text(
      //               AboutUsCubit.get(context).aboutUsResponse!.aboutUs,
      //               textAlign: TextAlign.justify,
      //               overflow: TextOverflow.clip,
      //             )
      //           ],
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
