// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:pets_adventure_frontend/src/core/dto/response_dto.dart';
import 'package:pets_adventure_frontend/src/core/error/global_exception.dart';
import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/model/tokenization_model.dart';
import 'package:pets_adventure_frontend/src/feature/auth/state/auth_state.dart';
import 'package:uno/uno.dart';

class AuthStore extends StreamStore<GlobalException, AuthState> {
  final Uno uno;

  AuthStore(this.uno) : super(InProcess());

  Future<void> login(LoginCredential credential) async {
    setLoading(true);
    var basic = '${credential.email.value}:${credential.password.value}';
    basic = base64Encode(basic.codeUnits);
    try {
      final response = await uno.get(
        '/auth/login',
        headers: {'authorization': 'basic $basic'},
      );
      final tokenization = TokenizationModel.fromMap(response.data);
      update(Logged(tokenization));
    } on UnoError<dynamic> catch (e, s) {
      final responseDto = ResponseDto.fromMap(e.response!.data);
      setError(GlobalException(responseDto.error, s));
    }
  }

  Future<void> refreshToken() async {
    final state = this.state;
    if (state is Logged) {
      final refreshTokenString = state.tokenization.refreshToken;
      final response = await uno.get('auth/refresh_token', headers: {
        'refreshed_token': '',
        'authorization': 'bearer $refreshTokenString',
      });
      final tokenization = TokenizationModel.fromMap(response.data);
      update(Logged(tokenization));
    }
  }

  void logout() {
    update(NotLogged());
  }
}
