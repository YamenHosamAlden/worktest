import 'package:worktest/App/app.dart';
import 'package:worktest/Bloc/bloc_observer/BlocObservable.dart';
import 'package:worktest/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();

  Bloc.observer = BlocObservable();
  print("token is ${AppSharedPreferences.getToken}");
  print("Language is ${AppSharedPreferences.getArLang}");
  print("theme is ${AppSharedPreferences.getTheme}");
  print("first name is ${AppSharedPreferences.getFirstName}");
  print("last name is ${AppSharedPreferences.getLastName}");
  print("email is ${AppSharedPreferences.getEmail}");
  print("phone is ${AppSharedPreferences.getPhone}");
  print("password is ${AppSharedPreferences.getPassword}");

  runApp(const MyApp());
}
