// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;

  final String password;
  LoginEvent({
    required this.email,
    required this.password,
  });
}

class SignUpEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
   final String phone;
  final String password;
  SignUpEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });
}

class LogOutEvent extends AuthEvent {}
