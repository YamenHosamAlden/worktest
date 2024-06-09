import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:worktest/App/app_localizations.dart';
import 'package:worktest/Bloc/main_bloc/main_bloc.dart';
import 'package:worktest/Core/Constants/app_assets.dart';
import 'package:worktest/Screens/Profile/Widgets/menu_item.dart';
import 'package:worktest/Screens/Profile/edit_profile_screen.dart';
import 'package:worktest/Screens/Profile/language_screen.dart';
import 'package:worktest/Screens/Splash/splash_screen.dart';
import 'package:worktest/Util/Dialogs/confirm_dialog.dart';
import 'package:worktest/Util/Dialogs/theme_pop_up.dart';
import 'package:worktest/Util/GeneralRoute.dart';
import 'package:worktest/Util/SharedPreferences/SharedPreferencesHelper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 4.h,
                ),
                MenuItemm(
                  title: "Basic Info".tr(context),
                  onPressed: () {
                    GeneralRoute.navigatorPushWithContext(
                        context, EditProfileScreen());
                  },
                  image: AppAssets.profileIcon,
                ),
                MenuItemm(
                  title: "Language".tr(context),
                  onPressed: () {
                    GeneralRoute.navigatorPushWithContext(
                        context, const LanguageScreen());
                  },
                  image: AppAssets.langIcon,
                ),
                MenuItemm(
                  title: "Theme".tr(context),
                  onPressed: () {
                    popUpChooseTheme(context);
                  },
                  image: AppAssets.themesIcon,
                ),
                MenuItemm(
                  title: "Log Out".tr(context),
                  onPressed: () {
                    showConfirmDialog(context,
                        title: "Are you sure you want to log out?".tr(context),
                        onPressed: () {
                      AppSharedPreferences.removeEmail();
                      AppSharedPreferences.removeFirstName();
                      AppSharedPreferences.removeLastName();
                      AppSharedPreferences.removePhone();
                      AppSharedPreferences.removePassword();
                      BlocProvider.of<MainBloc>(context).currentIndex = 0;
          
                      GeneralRoute.navigatorPushAndRemoveScreensWithContext(
                          context, const SplashScreen());
                    });
                  },
                  image: AppAssets.logoutIcon,
                ),
              ]),
            ),
          )),
    );
  }
}
