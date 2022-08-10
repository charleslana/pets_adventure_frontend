import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/feature/auth_guard.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';

class HomeModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute<dynamic>(
          Modular.initialRoute,
          child: (_, __) => const HomePage(),
          guards: [AuthGuard()],
        ),
      ];
}
