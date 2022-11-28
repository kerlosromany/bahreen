// ignore_for_file: deprecated_member_use

import 'package:elbahreen/business_logic/contact_us_cubit/contact_us_cubit.dart';
import 'package:elbahreen/business_logic/favourite_cubit/favourite_cubit.dart';
import 'package:elbahreen/business_logic/filter_cubit/filter_cubit.dart';
import 'package:elbahreen/business_logic/global_cubit/global_state.dart';
import 'package:elbahreen/business_logic/notifications_cubit/notifications_cubit.dart';
import 'package:elbahreen/business_logic/rate_cubit/rate_cubit.dart';
import 'package:elbahreen/business_logic/store_cubit/stores_cubit.dart';
import 'package:elbahreen/business_logic/store_details_cubit/store_details_cubit.dart';
import 'package:elbahreen/business_logic/sub_category_cubit/sub_category_cubit.dart';
import 'package:elbahreen/data/data_provider/local/cache_helper.dart';
import 'package:elbahreen/data/data_provider/remote/dio_helper.dart';
import 'package:elbahreen/presentation/screens/shared/error_screen.dart';
import 'package:elbahreen/presentation/view/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

import 'business_logic/bloc_observer.dart';
import 'business_logic/global_cubit/global_cubit.dart';
import 'constants/app_strings.dart';
import 'presentation/router/app_router.dart';
import 'presentation/router/app_router_names.dart';
import 'presentation/styles/themes.dart';

late LocalizationDelegate delegate;

Future<void> main() async {
  customError();
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      await CacheHelper.init();
      CacheHelper.saveDataSharedPreference(key: 'language', value: "ar");
      CacheHelper.saveDataSharedPreference(key: 'deviceId', value: "DAWB3H2aLBx5x4knhTGgN8uxxcrnDmi5Yn56Q95L");
      final locale =
          CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar";
      delegate = await LocalizationDelegate.create(
        fallbackLocale: locale,
        supportedLocales: ['ar', 'en'],
      );
      await delegate.changeLocale(Locale(locale));
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({required this.appRouter, Key? key}) : super(key: key);
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Intl.defaultLocale = delegate.currentLocale.languageCode;

    delegate.onLocaleChanged = (Locale value) async {
      try {
        setState(() {
          Intl.defaultLocale = value.languageCode;
        });
      } catch (e) {
        showToast(e.toString());
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: ((context) => GlobalCubit()..checkConnection()..getFirstUser()..getAds()..getCategories(page: 0))),
        BlocProvider(
            create: ((context) => NotificationsCubit()..getNotifications())),
        BlocProvider(create: ((context) => SubCategoryCubit())),
        BlocProvider(create: ((context) => ContactUsCubit())),
        BlocProvider(create: ((context) => FilterCubit())),
        BlocProvider(create: ((context) => StoreCubit()..getStores())),
        BlocProvider(create: ((context) => StoreDetailsCubit())),
        BlocProvider(create: ((context) => RateCubit())),
        BlocProvider(create: ((context) => FavouriteCubit())),
      ],
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LayoutBuilder(builder: (context, constraints) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: translate(AppStrings.sTitle),
                  localizationsDelegates: [
                    GlobalCupertinoLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    delegate,
                  ],
                  locale: delegate.currentLocale,
                  supportedLocales: delegate.supportedLocales,
                  onGenerateRoute: widget.appRouter.onGenerateRoute,
                  initialRoute: AppRouterNames.rSplashRoute,
                  theme: appTheme,
                );
              });
            },
          );
        },
      ),
    );
  }
}
