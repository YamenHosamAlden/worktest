import 'package:worktest/App/app_localizations.dart';
import 'package:worktest/Bloc/auth_bloc/auth_bloc.dart';
import 'package:worktest/Core/Constants/app_assets.dart';
import 'package:worktest/Core/Constants/app_colors.dart';
import 'package:worktest/Util/Dialogs/dialog_loading.dart';
import 'package:worktest/Util/Dialogs/localization_pop_up.dart';
import 'package:worktest/Screens/Auth/sign_up_screen.dart';
import 'package:worktest/Screens/Main/main_screen.dart';
import 'package:worktest/Util/GeneralRoute.dart';
import 'package:worktest/Widgets/custom_button.dart';
import 'package:worktest/Widgets/custom_text.dart';
import 'package:worktest/Widgets/custom_text_falid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({
    super.key,
  });

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    popUpChooseLocale(context);
                  },
                  icon: Image.asset(
                    AppAssets.langIcon,
                    height: 5.h,
                    width: 10.w,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: Center(
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            textData: "Hi, Welcome Customer!".tr(context),
                            textStyle: Theme.of(context).textTheme.headlineMedium,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            textData: "Hope you're doing fine.".tr(context),
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
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
                          controller: passwordController,
                          prefixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 2.h),
                              child: Image(
                                image: const AssetImage(AppAssets.lockIcon),
                                color: Theme.of(context).primaryColor,
                                width: 5.w,
                                height: 2.h,
                                fit: BoxFit.fill,
                              )),
                          textInputType: TextInputType.visiblePassword,
                          isPassword: true,
                          hintText: "Enter Your Password".tr(context),
                          validator: (input) {
                            if (input!.isEmpty) {
                              return "Please Enter Your Password".tr(context);
                            }
                  
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      BlocListener<AuthBloc, AuthStates>(
                        listener: (context, state) {
                          if (state is LogInLoadingState) {
                            showLoaderDialog(context);
                          }
                          if (state is LogInErrorState) {
                            GeneralRoute.navigatorPobWithContext(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: AppColors.redColor,
                              duration: const Duration(seconds: 5),
                              content: Text(
                                state.message,
                              ),
                            ));
                          }
                          if (state is LogInSuccesfulState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: AppColors.greanColor,
                              duration: const Duration(seconds: 5),
                              content: Text(
                                "LogIn Succesful".tr(context),
                              ),
                            ));
                            GeneralRoute.navigatorPushAndRemoveScreensWithContext(
                                context, const MainScreen());
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: CustomButton(
                            // buttonColor: Theme.of(context).primaryColor,
                            // textColor: Theme.of(context).textTheme.labelSmall!.color,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authBloc.add(LoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ));
                  
                                // GeneralRoute
                                //     .navigatorPushAndRemoveScreensWithContext(
                                //         context, const MainScreen());
                              }
                            },
                            buttonText: "Log In".tr(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                            child: Divider(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )),
                          CustomText(
                            textData: "Or".tr(context),
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                            child: Divider(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: CustomText(
                                textData: "Forgot password?".tr(context),
                                textStyle: Theme.of(context).textTheme.labelSmall,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            textData: "Don’t have an account yet?".tr(context),
                            textStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextButton(
                              onPressed: () {
                                GeneralRoute.navigatorPushWithContext(
                                    context, const SignUpScreen());
                              },
                              child: CustomText(
                                textData: "Sign up".tr(context),
                                textStyle: Theme.of(context).textTheme.labelSmall,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
