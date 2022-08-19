// ignore_for_file: sort_constructors_first

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:pets_adventure_frontend/src/core/const/shared_local_storage_const.dart';
import 'package:pets_adventure_frontend/src/core/const/version_const.dart';
import 'package:pets_adventure_frontend/src/core/error/global_exception.dart';
import 'package:pets_adventure_frontend/src/core/service/encrypt_service.dart';
import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/landing/service/landing_service.dart';
import 'package:pets_adventure_frontend/src/feature/landing/state/landing_state.dart';
import 'package:uno/uno.dart';

class LandingStore extends StreamStore<GlobalException, LandingState> {
  final Uno uno;
  final LandingService landingService;

  LandingStore(
    this.uno,
    this.landingService,
  ) : super(ValidateVersion());

  @override
  void initStore() {
    getVersion();
    super.initStore();
  }

  void showError(String message) {
    setError(GlobalException(message));
  }

  Future<void> getVersion() async {
    setLoading(true);
    try {
      final version = await landingService.getVersion();
      _validateVersion(version);
    } on UnoError<dynamic> catch (_) {
      update(NoConnection());
      setLoading(false);
    }
  }

  void _validateVersion(String version) {
    if (version != appVersion) {
      update(OutdatedVersion());
      return;
    }
    update(ValidateAccount());
    _fetchLogin();
  }

  Future<void> _fetchLogin() async {
    final store = Modular.get<AuthStore>();
    final encryptService = Modular.get<EncryptService>();
    final username = await store.sharedLocalStorageService.get(usernameKey);
    final password = await store.sharedLocalStorageService.get(passwordKey);
    final loginCredential = LoginCredential()
      ..setEmail(encryptService.decrypt(username ?? ''))
      ..setPassword(encryptService.decrypt(password ?? ''));
    try {
      await store.login(loginCredential);
    } on UnoError<dynamic> catch (e) {
      setLoading(false);
      if (e.response == null) {
        update(NoConnection());
        return;
      }
    }
  }
}
