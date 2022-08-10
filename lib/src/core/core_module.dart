import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/feature/auth/service/auth_service.dart';

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<AuthService>((i) => AuthService(i()), export: true),
      ];
}
