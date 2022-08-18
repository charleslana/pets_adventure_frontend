import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/feature/register/register_page.dart';

class RegisterModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute<dynamic>(Modular.initialRoute,
            child: (_, __) => const RegisterPage()),
      ];
}
