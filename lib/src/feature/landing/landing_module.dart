import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/feature/landing/landing_page.dart';

class LandingModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute<dynamic>(
          Modular.initialRoute,
          child: (_, __) => const LandingPage(),
        ),
      ];
}
