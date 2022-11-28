import 'package:elbahreen/presentation/screens/shared/connection_screen.dart';
import 'package:elbahreen/presentation/screens/shared/favorite_screen.dart';
import 'package:elbahreen/presentation/screens/shared/filter_result_screen.dart';
import 'package:elbahreen/presentation/screens/shared/searchSreen.dart';
import 'package:elbahreen/presentation/screens/shared/who_are_we_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/shared/contact_us_screen.dart';
import '../screens/shared/join_trader_screen.dart';
import 'app_router_names.dart';
import '../screens/shared/store_details_screen.dart';
import '../screens/shared/stores_screen.dart';
import '../screens/shared/filter_screen.dart';
import '../screens/shared/home_screen.dart';
import '../screens/shared/splash_screen.dart';
import '../screens/shared/notification_screen.dart';
import '../screens/shared/sub_category_screen.dart';
import 'arguments/filter_arguments.dart';
import 'arguments/store_details_arguments.dart';
import 'arguments/stores_arguments.dart';
import 'arguments/sub_category_argument.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rSplashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRouterNames.rHomeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRouterNames.rSubCategoryRoute:
        SubCategoryArguments arguments =
            settings.arguments as SubCategoryArguments;
        return MaterialPageRoute(builder: (_) => SubCategoryScreen(arguments));
      case AppRouterNames.rStoreRoute:
        StoresArguments arguments = settings.arguments as StoresArguments;
        return MaterialPageRoute(builder: (_) => StoresScreen(arguments));
      case AppRouterNames.rSearch:
        StoresArguments arguments = settings.arguments as StoresArguments;
        return MaterialPageRoute(builder: (_) => SearchScreen(arguments));
      case AppRouterNames.rStoreDetailsRoute:
        StoreDetailsArguments arguments = 
            settings.arguments as StoreDetailsArguments;
        return MaterialPageRoute(
            builder: (_) => StoreDetailsScreen(arguments));
      case AppRouterNames.rNotificationsRoute:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case AppRouterNames.rFilterResult:
        FilterArguments arguments = settings.arguments as FilterArguments;
        return MaterialPageRoute(
            builder: (_) => FilterResultScreen(
                  filterArguments: arguments,
                ));
      case AppRouterNames.rWhoAreWeRoute:
        return MaterialPageRoute(builder: (_) => WhoAreWeScreen());
      case AppRouterNames.favorite:
        return MaterialPageRoute(builder: (_) => FavoriteScreen());
      case AppRouterNames.rContactUsRoute:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
      case AppRouterNames.rFilterRoute:
        FilterArguments arguments = settings.arguments as FilterArguments;
        return MaterialPageRoute(builder: (_) => FilterSearchScreen(arguments));
      case AppRouterNames.connection:
        return MaterialPageRoute(builder: (_) => const ConnectionScreen());
      case AppRouterNames.traderJoinRoute:
        return MaterialPageRoute(builder: (_) => JoinTraderScreen());
      default:
        return null;
    }
  }
}
