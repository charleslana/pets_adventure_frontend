import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/auth/state/auth_state.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';
import 'package:pets_adventure_frontend/src/feature/landing/state/landing_state.dart';
import 'package:pets_adventure_frontend/src/feature/landing/store/landing_store.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  static const routeName = '/landing/';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLoading = true;
  String loadingText = 'Validando versão...';

  @override
  void initState() {
    context.read<LandingStore>().observer(
          onLoading: (isLoading) => {
            if (isLoading)
              {
                setState(() {
                  this.isLoading = true;
                }),
              }
            else
              {
                setState(() {
                  this.isLoading = false;
                }),
              }
          },
          onState: (state) => {
            if (state is OutdatedVersion)
              {
                setState(() {
                  isLoading = false;
                  loadingText =
                      'O aplicativo se encontra desatualizado, por favor atualize em sua loja de aplicações';
                }),
              },
            if (state is NoConnection)
              {
                setState(() {
                  isLoading = false;
                  loadingText = 'Falha ao conectar com o servidor';
                }),
              },
            if (state is ValidateAccount)
              {
                setState(() {
                  loadingText = 'Validando conta...';
                }),
              }
          },
        );
    context.read<AuthStore>().observer(onState: (state) {
      if (state is Logged) {
        Modular.to.navigate(HomePage.routeName);
      } else if (state is NotLogged) {
        Modular.to.navigate(LoginPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading) const LinearProgressIndicator(),
                const SizedBox(height: 5),
                Text(
                  loadingText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
