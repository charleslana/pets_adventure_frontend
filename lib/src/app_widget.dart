import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/auth/state/auth_state.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  // @override
  // void initState() {
  //   context.read<AuthStore>().observer(onState: (state) {
  //     if (state is Logged) {
  //       // home
  //       Modular.to.navigate(HomePage.routeName);
  //     } else if (state is NotLogged) {
  //       // auth
  //       Modular.to.navigate(LoginPage.routeName);
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(LoginPage.routeName);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pets Adventure',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
