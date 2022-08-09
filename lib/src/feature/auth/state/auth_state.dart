// ignore_for_file: sort_constructors_first

import 'package:pets_adventure_frontend/src/feature/auth/model/tokenization_model.dart';

abstract class AuthState {}

class InProcess extends AuthState {}

class Logged extends AuthState {
  final TokenizationModel tokenization;

  Logged(this.tokenization);
}

class NotLogged extends AuthState {}
