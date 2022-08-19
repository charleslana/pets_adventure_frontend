// ignore_for_file: sort_constructors_first

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:pets_adventure_frontend/src/core/dto/response_error_dto.dart';
import 'package:pets_adventure_frontend/src/core/error/global_exception.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/register/dto/register_dto.dart';
import 'package:pets_adventure_frontend/src/feature/register/service/register_service.dart';
import 'package:pets_adventure_frontend/src/feature/register/state/register_state.dart';
import 'package:uno/uno.dart';

class RegisterStore extends StreamStore<GlobalException, RegisterState> {
  final Uno uno;
  final RegisterService registerService;

  RegisterStore(
    this.uno,
    this.registerService,
  ) : super(RegistrationInProcess());

  void showError(String message) {
    setError(GlobalException(message));
  }

  Future<void> register(RegisterDto register) async {
    setLoading(true);
    try {
      final response = await registerService.createAccount(register);
      update(Registered(response));
      setLoading(false);
      Modular.dispose<RegisterStore>();
      Modular.to.navigate(LoginPage.routeName);
    } on UnoError<dynamic> catch (e, s) {
      update(NotRegistered());
      setLoading(false);
      if (e.response == null) {
        setError(GlobalException('Falhar ao conectar com o servidor'));
        return;
      }
      final responseDto = ResponseErrorDto.fromMap(e.response!.data);
      setError(GlobalException(responseDto.error, s));
    }
  }
}
