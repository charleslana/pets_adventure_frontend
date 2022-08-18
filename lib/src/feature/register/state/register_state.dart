// ignore_for_file: sort_constructors_first

import 'package:pets_adventure_frontend/src/core/dto/response_success_dto.dart';

abstract class RegisterState {}

class RegistrationInProcess extends RegisterState {}

class NotRegistered extends RegisterState {}

class Registered extends RegisterState {
  final ResponseSuccessDto response;

  Registered(this.response);
}
