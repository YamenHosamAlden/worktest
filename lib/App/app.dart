import 'package:worktest/App/app_localizations.dart';
import 'package:worktest/Bloc/app_language_bloc/app_language_bloc.dart';
import 'package:worktest/Bloc/app_theme_bloc/app_theme_bloc.dart';
import 'package:worktest/Bloc/auth_bloc/auth_bloc.dart';
import 'package:worktest/Bloc/categories_bloc/categories_bloc.dart';
import 'package:worktest/Bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:worktest/Bloc/main_bloc/main_bloc.dart';
import 'package:worktest/Bloc/product_bloc/product_bloc.dart';
import 'package:worktest/Core/theme/dark_theme.dart';
import 'package:worktest/Core/theme/light_theme.dart';
import 'package:worktest/Screens/Splash/splash_screen.dart';
import 'package:worktest/Util/GeneralRoute.dart';
import 'package:worktest/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:worktest/Util/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sizer/sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppLanguageBloc()..add(InitLanguage()),
            ),
            BlocProvider(
              create: (context) => AppThemeBloc()..add(LoadCurrentThemeEvent()),
            ),
            BlocProvider(
              create: (context) => ConnectivityBloc(),
            ),
            BlocProvider(
              create: (context) => MainBloc(),
            ),
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => CategoriesBloc(),
            ),
            BlocProvider(
              create: (context) => ProductBloc(),
            ),
          ],
          child: BlocBuilder<AppThemeBloc, ThemeChangeState>(
            builder: (context, state) {
              return BlocBuilder<AppLanguageBloc, ChangeLanguageState>(
                builder: (context, state) {
                  return MaterialApp(
                    color: Theme.of(context).primaryColor,
                    title: Environment.appName,
                    themeMode: BlocProvider.of<AppThemeBloc>(context).darkTheme
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    theme: light,
                    darkTheme: dark,
                    debugShowCheckedModeBanner: false,
                    locale: Locale(AppSharedPreferences.getArLang),
                    supportedLocales: const [Locale('en', 'US'), Locale('ar')],
                    localizationsDelegates: const [
                      Applocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate
                    ],
                    navigatorKey: GeneralRoute.navigatorKey,
                    localeResolutionCallback: (deviceLocale, supportedLocales) {
                      for (var locale in supportedLocales) {
                        if (deviceLocale != null &&
                            deviceLocale.languageCode == locale.languageCode) {
                          return deviceLocale;
                        }
                      }
                      return supportedLocales.first;
                    },
                    home: const SplashScreen(),
                  );
                },
              );
            },
          )),
    );
  }
}
