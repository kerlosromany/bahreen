import 'package:elbahreen/business_logic/notifications_cubit/notifications_cubit.dart';
import 'package:elbahreen/business_logic/notifications_cubit/notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/app_strings.dart';
import '../../view/notification_body_view.dart';
import '../../view/side_menu_view.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit()..getNotifications(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate(AppStrings.sNotifications),style: TextStyle(fontSize: 11.sp)),
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
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
          if (state is! SuccessGetNotificationsState) {
            return const SizedBox();
          }
          return NotificationBodyView(NotificationsCubit.get(context)
              .notificationsResponse!
              .notifications);
        }),
      ),
    );
  }
}
