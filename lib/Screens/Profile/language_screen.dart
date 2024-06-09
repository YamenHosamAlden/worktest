import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:worktest/App/app_localizations.dart';
import 'package:worktest/Bloc/app_language_bloc/app_language_bloc.dart';
import 'package:worktest/Util/GeneralRoute.dart';
import 'package:worktest/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:worktest/Widgets/app_bar_widget.dart';
import 'package:worktest/Widgets/custom_button.dart';
import 'package:worktest/Widgets/custom_text.dart';

enum Lang { english, arabic }

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late Lang? lang;

  @override
  void initState() {
    super.initState();
    if (AppSharedPreferences.hasArLang) {
      lang = Lang.arabic;
    } else {
      lang = Lang.english;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, title: "Language".tr(context)),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                shrinkWrap: true,
                children: [
                  RadioListTile<Lang>(
                    title: CustomText(
                      textData: 'English',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    groupValue: lang,
                    value: Lang.english,
                    onChanged: (newLang) {
                      setState(() {
                        lang = newLang;
                      });
                    },
                  ),
                  RadioListTile<Lang>(
                    title: CustomText(
                      textData: 'العربية',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    groupValue: lang,
                    value: Lang.arabic,
                    onChanged: (Lang? newLang) {
                      setState(() {
                        lang = newLang;
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        GeneralRoute.navigatorPobWithContext(context);
                      },
                      buttonText: "Cancel".tr(context),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        if (lang == Lang.english) {
                          BlocProvider.of<AppLanguageBloc>(context)
                              .add(ChangeLanguageToEn());
                        } else {
                          BlocProvider.of<AppLanguageBloc>(context)
                              .add(ChangeLanguageToAr());
                        }
                      },
                      buttonText: "Save".tr(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            )
          ],
        ));
  }
}
