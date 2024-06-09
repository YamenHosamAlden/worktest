import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:worktest/App/app_localizations.dart';
import 'package:worktest/Core/Constants/app_assets.dart';
import 'package:worktest/Util/GeneralRoute.dart';
import 'package:worktest/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:worktest/Widgets/app_bar_widget.dart';
import 'package:worktest/Widgets/custom_button.dart';
import 'package:worktest/Widgets/custom_text_falid.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController emailController = TextEditingController();

  late TextEditingController phoneController = TextEditingController();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    firstNameController =
        TextEditingController(text: AppSharedPreferences.getFirstName);
    lastNameController =
        TextEditingController(text: AppSharedPreferences.getLastName);
    emailController =
        TextEditingController(text: AppSharedPreferences.getEmail);

    phoneController =
        TextEditingController(text: AppSharedPreferences.getPhone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, title: "Basic Info".tr(context)),
        body: Column(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: Center(
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: firstNameController,
                                textInputType: TextInputType.name,
                                hintText: "Enter Your First Name".tr(context),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Please Enter Your First Name"
                                        .tr(context);
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: CustomTextField(
                                controller: lastNameController,
                                textInputType: TextInputType.name,
                                hintText: "Enter Your Last Name".tr(context),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Please Enter Your Last Name"
                                        .tr(context);
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: CustomTextField(
                          controller: emailController,
                          prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 2.h),
                              child: Image(
                                image: const AssetImage(AppAssets.smsIcon),
                                color: Theme.of(context).primaryColor,
                                width: 5.w,
                                height: 2.h,
                                fit: BoxFit.fill,
                              )),
                          textInputType: TextInputType.emailAddress,
                          hintText: "Enter Your Email".tr(context),
                          validator: (input) {
                            if (input!.isEmpty) {
                              return "Please Enter Your Email".tr(context);
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: CustomTextField(
                          hintText: "Enter Your Phone".tr(context),
                          controller: phoneController,
                          prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 2.h),
                              child: Image(
                                image: const AssetImage(AppAssets.phoneIcon),
                                color: Theme.of(context).primaryColor,
                                width: 5.w,
                                height: 2.h,
                                fit: BoxFit.fill,
                              )),
                          textInputType: TextInputType.phone,
                          validator: (input) {
                            if (input!.isEmpty) {
                              return "Please Enter Your Phone".tr(context);
                            }
                            if (input.length == 9) {
                              return "The phone number must be 9 numbers";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await AppSharedPreferences.saveEmail(
                              emailController.text);
                          await AppSharedPreferences.saveFirstName(
                              firstNameController.text);
                          await AppSharedPreferences.saveLastName(
                              lastNameController.text);
                          await AppSharedPreferences.savePhone(
                              phoneController.text);
                          if (context.mounted) {
                            GeneralRoute.navigatorPobWithContext(context);
                          }
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
