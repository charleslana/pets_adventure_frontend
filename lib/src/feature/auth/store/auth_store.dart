// ignore_for_file: sort_constructors_first

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:pets_adventure_frontend/src/core/const/shared_local_storage_const.dart';
import 'package:pets_adventure_frontend/src/core/dto/response_dto.dart';
import 'package:pets_adventure_frontend/src/core/error/global_exception.dart';
import 'package:pets_adventure_frontend/src/core/service/encrypt_service.dart';
import 'package:pets_adventure_frontend/src/core/service/shared_local_storage_service.dart';
import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/auth/service/auth_service.dart';
import 'package:pets_adventure_frontend/src/feature/auth/state/auth_state.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';
import 'package:uno/uno.dart';

class AuthStore extends StreamStore<GlobalException, AuthState> {
  final Uno uno;
  final AuthService authService;
  final SharedLocalStorageService sharedLocalStorageService;
  final EncryptService encryptService;

  AuthStore(
    this.uno,
    this.authService,
    this.sharedLocalStorageService,
    this.encryptService,
  ) : super(InProcess());

  Future<void> login(LoginCredential credential) async {
    setLoading(true);
    try {
      final tokenization = await authService.login(credential);
      update(Logged(tokenization));
      await sharedLocalStorageService.put(
          usernameKey, encryptService.encrypt(credential.email.value));
      await sharedLocalStorageService.put(
          passwordKey, encryptService.encrypt(credential.password.value));
      setLoading(false);
      Modular.to.navigate(HomePage.routeName);
    } on UnoError<dynamic> catch (e, s) {
      update(NotLogged());
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
    sharedLocalStorageService
      ..delete(usernameKey)
      ..delete(passwordKey);
    Modular.dispose<AuthStore>();
    Modular.to.navigate(LoginPage.routeName);
  }

  void showError(String message) {
    setError(GlobalException(message));
  }

  bool isLogged() {
    if (state is Logged) {
      return true;
    }
    return false;
  }
}
