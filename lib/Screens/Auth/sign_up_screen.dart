import 'package:worktest/App/app_localizations.dart';
import 'package:worktest/Bloc/auth_bloc/auth_bloc.dart';
import 'package:worktest/Core/Constants/app_assets.dart';
import 'package:worktest/Core/Constants/app_colors.dart';
import 'package:worktest/Util/Dialogs/dialog_loading.dart';
import 'package:worktest/Util/Dialogs/localization_pop_up.dart';
import 'package:worktest/Screens/Main/main_screen.dart';
import 'package:worktest/Util/GeneralRoute.dart';
import 'package:worktest/Widgets/custom_button.dart';
import 'package:worktest/Widgets/custom_text.dart';
import 'package:worktest/Widgets/custom_text_falid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

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
        body: BlocListener<AuthBloc, AuthStates>(
            listener: (context, state) {
              if (state is SignUpLoadingState) {
                showLoaderDialog(context);
              }
              if (state is SignUpErrorState) {
                GeneralRoute.navigatorPobWithContext(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColors.redColor,
                  duration: const Duration(seconds: 5),
                  content: Text(
                    state.message,
                  ),
                ));
              }
              if (state is SignUpSuccesfulState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColors.greanColor,
                  duration: const Duration(seconds: 5),
                  content: Text(
                    "SignUp Succesful".tr(context),
                  ),
                ));
                // GeneralRoute.navigatorPobWithContext(context);
                GeneralRoute.navigatorPushAndRemoveScreensWithContext(
                    context, const MainScreen());
              }
            },
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              GeneralRoute.navigatorPobWithContext(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              color: Theme.of(context).primaryColor,
                              size: 8.w,
                            )),
                        IconButton(
                          onPressed: () {
                            popUpChooseLocale(context);
                          },
                          icon: Image.asset(
                            AppAssets.langIcon,
                            height: 5.h,
                            width: 10.w,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
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
                                  textData: "Create Account".tr(context),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: firstNameController,
                                      textInputType: TextInputType.name,
                                      hintText:
                                          "Enter Your First Name".tr(context),
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
                                      hintText:
                                          "Enter Your Last Name".tr(context),
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
                                      image:
                                          const AssetImage(AppAssets.smsIcon),
                                      color: Theme.of(context).primaryColor,
                                      width: 5.w,
                                      height: 2.h,
                                      fit: BoxFit.fill,
                                    )),
                                textInputType: TextInputType.emailAddress,
                                hintText: "Enter Your Email".tr(context),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Please Enter Your Email"
                                        .tr(context);
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
                                      image:
                                          const AssetImage(AppAssets.phoneIcon),
                                      color: Theme.of(context).primaryColor,
                                      width: 5.w,
                                      height: 2.h,
                                      fit: BoxFit.fill,
                                    )),
                                textInputType: TextInputType.phone,
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Please Enter Your Phone"
                                        .tr(context);
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: CustomTextField(
                                controller: passwordController,
                                prefixIcon: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 2.h),
                                    child: Image(
                                      image:
                                          const AssetImage(AppAssets.lockIcon),
                                      color: Theme.of(context).primaryColor,
                                      width: 5.w,
                                      height: 2.h,
                                      fit: BoxFit.fill,
                                    )),
                                textInputType: TextInputType.visiblePassword,

                                isPassword: true,

                                hintText: "Enter Your Password".tr(context),
                                // validatorMessage:
                                //     "Please Enter Your Password".tr(context),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authBloc.add(SignUpEvent(
                                        email: emailController.text,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text));
                                  }
                                },
                                textColor: AppColors.textFieldColor,
                                buttonText: "Create Account".tr(context),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.5.w),
                                  child: Divider(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                )),
                                CustomText(
                                  textData: "Or".tr(context),
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.5.w),
                                  child: Divider(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  textData:
                                      "Do you have an account ?".tr(context),
                                  textStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                TextButton(
                                    onPressed: () {
                                      GeneralRoute.navigatorPobWithContext(
                                          context);
                                    },
                                    child: CustomText(
                                      textData: "Sign In".tr(context),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
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
            )));
  }
}
