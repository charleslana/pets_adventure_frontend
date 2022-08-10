import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: LoginPage.routeName);

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    return Modular.get<AuthStore>().isLogged();
  }
}
