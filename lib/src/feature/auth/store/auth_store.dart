// ignore_for_file: sort_constructors_first

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:pets_adventure_frontend/src/core/dto/response_dto.dart';
import 'package:pets_adventure_frontend/src/core/error/global_exception.dart';
import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/service/auth_service.dart';
import 'package:pets_adventure_frontend/src/feature/auth/state/auth_state.dart';
import 'package:uno/uno.dart';

class AuthStore extends StreamStore<GlobalException, AuthState> {
  final Uno uno;
  final AuthService authService;

  AuthStore(
    this.uno,
    this.authService,
  ) : super(InProcess());

  Future<void> login(LoginCredential credential) async {
    setLoading(true);
    try {
      final tokenization = await authService.login(credential);
      update(Logged(tokenization));
      setLoading(false);
    } on UnoError<dynamic> catch (e, s) {
      setLoading(false);
      final responseDto = ResponseDto.fromMap(e.response!.data);
      setError(GlobalException(responseDto.error, s));
    }
  }

  Future<void> refreshToken() async {
    final state = this.state;
    if (state is Logged) {
      final refreshTokenString = state.tokenization.refreshToken;
      final tokenization = await authService.refreshToken(refreshTokenString);
      update(Logged(tokenization));
    }
  }

  void logout() {
    update(NotLogged());
    Modular.to.navigate('/auth/login');
  }
}
