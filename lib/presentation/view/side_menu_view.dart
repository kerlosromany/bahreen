import 'package:elbahreen/business_logic/global_cubit/global_cubit.dart';
import 'package:elbahreen/business_logic/global_cubit/global_state.dart';
import 'package:elbahreen/constants/app_strings.dart';
import 'package:flutter/material.dart';

import 'package:elbahreen/presentation/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

import '../router/app_router_names.dart';

class SideMenuView extends StatelessWidget {
  const SideMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit()..getUnSeenNotifications()..getAboutUs(),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(2.2.h),
          bottomRight: Radius.circular(2.2.h),
        ),
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 20.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 23.w,right: 23.w,top: 2.h,bottom: 2.h),
                  child: Opacity(
                    opacity: 0.9,
                    child: Image.asset(
                      "assets/images/b1.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              MenuItem(
                title: translate(AppStrings.sHome),
                icon: Icons.home,
                onTapCallBack: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, AppRouterNames.rHomeRoute);
                },
                haveIcon: false,
              ),
              const Divider(),
              BlocBuilder<GlobalCubit, GlobalState>(
                builder: (context, state) {
                  if(state is! SuccessGetUnSeenState){
                    return MenuItem(
                      title: translate(AppStrings.sNotifications),
                      icon: Icons.notifications,
                      onTapCallBack: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, AppRouterNames.rNotificationsRoute);
                      },
                      haveIcon: false,
                    );
                  }
                  return MenuItem(
                    title: translate(AppStrings.sNotifications),
                    icon: Icons.notifications,
                    onTapCallBack: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, AppRouterNames.rNotificationsRoute);
                    },
                    haveIcon: true,
                    count: GlobalCubit.get(context)
                        .unSeenNotificationsResponse!
                        .count,
                  );
                },
              ),
              const Divider(),
              MenuItem(
                title: translate(AppStrings.sContactUS),
                icon: Icons.call,
                onTapCallBack: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRouterNames.rContactUsRoute);
                },
                haveIcon: false,
              ),
              const Divider(),
              MenuItem(
                title: translate(AppStrings.sWhoAreWe),
                icon: Icons.info,
                onTapCallBack: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRouterNames.rWhoAreWeRoute);
                },
                haveIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTapCallBack;
  final bool haveIcon;
  final int? count;

  const MenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTapCallBack,
    required this.haveIcon,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon, size: 28.0, color: AppColor.red),
      trailing: haveIcon
          ? Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColor.red,
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          : const SizedBox(),
      onTap: onTapCallBack,
    );
  }
}
