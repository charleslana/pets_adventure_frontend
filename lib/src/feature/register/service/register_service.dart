// ignore_for_file: sort_constructors_first

import 'package:pets_adventure_frontend/src/core/dto/response_success_dto.dart';
import 'package:pets_adventure_frontend/src/feature/register/dto/register_dto.dart';
import 'package:uno/uno.dart';

class RegisterService {
  final Uno uno;

  RegisterService(this.uno);

  Future<ResponseSuccessDto> createAccount(RegisterDto register) async {
    final response = await uno.post('/user', data: {
      'email': register.email.value,
      'password': register.password.value,
    });
    return ResponseSuccessDto.fromMap(response.data);
  }
}
