import 'dart:async';

import 'package:worktest/App/app_localizations.dart';
import 'package:worktest/Bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:worktest/Core/Constants/app_assets.dart';
import 'package:worktest/Screens/Auth/log_in_screen.dart';
import 'package:worktest/Screens/Main/main_screen.dart';
import 'package:worktest/Util/GeneralRoute.dart';
import 'package:worktest/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:worktest/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (AppSharedPreferences.hasToken) {
        GeneralRoute.navigatorPushAndRemoveScreensWithContext(
            context, const MainScreen());
      } else {
          GeneralRoute.navigatorPushAndRemoveScreensWithContext(
            context, const LogInScreen());
      }
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<ConnectivityBloc, ConnectedState>(
        listener: (context, state) {
          if (state.message == "Connecting To Wifi") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message.tr(context),
              ),
            ));
          }
          if (state.message == "Connecting To Mobile Data") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message.tr(context),
              ),
            ));
          }
          if (state.message == "Lost Internet Connection") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message.tr(context),
              ),
            ));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.splashImage,
              height: 15.h,
              width: 30.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  textData: "Welcome Customer".tr(context),
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
