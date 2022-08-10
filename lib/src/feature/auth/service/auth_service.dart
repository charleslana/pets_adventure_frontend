// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/model/tokenization_model.dart';
import 'package:uno/uno.dart';

class AuthService {
  final Uno uno;

  AuthService(this.uno);

  Future<TokenizationModel> login(LoginCredential credential) async {
    var basic = '${credential.email.value}:${credential.password.value}';
    basic = base64Encode(basic.codeUnits);
    final response = await uno.get(
      '/auth/login',
      headers: {'authorization': 'basic $basic'},
    );
    return TokenizationModel.fromMap(response.data);
  }

  Future<TokenizationModel> refreshToken(String refreshTokenString) async {
    final response = await uno.get('auth/refresh_token', headers: {
      'refreshed_token': '',
      'authorization': 'bearer $refreshTokenString',
    });
    return TokenizationModel.fromMap(response.data);
  }
}
