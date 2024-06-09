import 'package:bloc/bloc.dart';
import 'package:worktest/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LogInLoadingState());

      if (event.email == AppSharedPreferences.getEmail &&
          event.password == AppSharedPreferences.getPassword) {
        emit(LogInSuccesfulState());
      } else {
        emit(LogInErrorState(message: "Check your email or password"));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        await AppSharedPreferences.saveEmail(event.email);
        await AppSharedPreferences.saveFirstName(event.firstName);
        await AppSharedPreferences.saveLastName(event.lastName);
        await AppSharedPreferences.savePhone(event.phone);
        await AppSharedPreferences.savePassword(event.password);

        emit(SignUpSuccesfulState());
      } catch (error) {
        emit(SignUpErrorState(message: "Error"));
      }
    });

    on<LogOutEvent>((event, emit) async {});
  }
}
