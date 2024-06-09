import 'package:worktest/Core/Constants/app_strings.dart';

import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  static SharedPreferencesProvider? sharedPreferencesProvider;
  static init() async {
    sharedPreferencesProvider = await SharedPreferencesProvider.getInstance();
  }

  //token
  static String get getToken =>
      sharedPreferencesProvider!.read(AppStrings.token) ?? '';
  static saveToken(String value) =>
      sharedPreferencesProvider!.save(AppStrings.token, value);
  static bool get hasToken =>
      sharedPreferencesProvider!.contains(AppStrings.token);
  static removeToken() => sharedPreferencesProvider!.remove(AppStrings.token);

  //FirstName
  static String get getFirstName =>
      sharedPreferencesProvider!.read(AppStrings.firstName) ?? '';
  static saveFirstName(String value) =>
      sharedPreferencesProvider!.save(AppStrings.firstName, value);
  static bool get hasfirstName =>
      sharedPreferencesProvider!.contains(AppStrings.firstName);
  static removeFirstName() =>
      sharedPreferencesProvider!.remove(AppStrings.firstName);

  //lastName
  static String get getLastName =>
      sharedPreferencesProvider!.read(AppStrings.lastName) ?? '';
  static saveLastName(String value) =>
      sharedPreferencesProvider!.save(AppStrings.lastName, value);
  static bool get haslastName =>
      sharedPreferencesProvider!.contains(AppStrings.lastName);
  static removeLastName() =>
      sharedPreferencesProvider!.remove(AppStrings.lastName);

  //email
  static String get getEmail =>
      sharedPreferencesProvider!.read(AppStrings.email) ?? '';
  static saveEmail(String value) =>
      sharedPreferencesProvider!.save(AppStrings.email, value);
  static bool get hasEmail =>
      sharedPreferencesProvider!.contains(AppStrings.email);
  static removeEmail() => sharedPreferencesProvider!.remove(AppStrings.email);

  //email
  static String get getPassword =>
      sharedPreferencesProvider!.read(AppStrings.password) ?? '';
  static savePassword(String value) =>
      sharedPreferencesProvider!.save(AppStrings.password, value);
  static bool get hasPassword =>
      sharedPreferencesProvider!.contains(AppStrings.password);
  static removePassword() =>
      sharedPreferencesProvider!.remove(AppStrings.password);

  //phone
  static String get getPhone =>
      sharedPreferencesProvider!.read(AppStrings.phone) ?? '';
  static savePhone(String value) =>
      sharedPreferencesProvider!.save(AppStrings.phone, value);
  static bool get hasPhone =>
      sharedPreferencesProvider!.contains(AppStrings.phone);
  static removePhone() => sharedPreferencesProvider!.remove(AppStrings.phone);

  //lang
  static String get getArLang =>
      sharedPreferencesProvider!.read(AppStrings.language) ?? "en";
  static saveArLang(String value) =>
      sharedPreferencesProvider!.save(AppStrings.language, value);
  static bool get hasArLang =>
      sharedPreferencesProvider!.contains(AppStrings.language);
  static removeArLang() =>
      sharedPreferencesProvider!.remove(AppStrings.language);

  //theme
  static bool get getTheme =>
      sharedPreferencesProvider!.read(AppStrings.theme) ?? false;
  static saveTheme(bool value) =>
      sharedPreferencesProvider!.save(AppStrings.theme, value);
  static bool get hasTheme =>
      sharedPreferencesProvider!.contains(AppStrings.theme);
  static removeTheme() => sharedPreferencesProvider!.remove(AppStrings.theme);

  static clearSharedPreferences() {
    sharedPreferencesProvider!.clear();
  }
}
