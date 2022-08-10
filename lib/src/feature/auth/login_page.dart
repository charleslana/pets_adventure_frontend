import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/core/widgets/app_loading.dart';
import 'package:pets_adventure_frontend/src/core/widgets/app_snack_bar.dart';
import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = '/auth/login/';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscured = true;
  final credential = LoginCredential();
  bool isObscuredPassword = true;
  bool isObscuredConfirmPassword = true;

  @override
  void initState() {
    context.read<AuthStore>().observer(
          onError: (e) {
            showSnackBar(context, e.message, SnackBarEnum.error);
          },
          onLoading: (isLoading) => {
            if (isLoading)
              {
                showLoading(context),
              }
            else
              {
                Navigator.of(context).pop(),
              }
          },
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AuthStore>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                height: 50,
                'https://seeklogo.com/images/J/jwt-logo-65D86B4640-seeklogo.com.png',
              ),
              const SizedBox(height: 60),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: credential.setEmail,
                validator: (value) => credential.email.validate(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: credential.setPassword,
                validator: (value) => credential.password.validate(),
                obscureText: isObscured,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final validate = credential.validate();
                  if (validate == null) {
                    await store.login(credential);
                  } else {
                    store.showError(validate);
                  }
                },
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () => _showRegisterModal(context),
                child: const Text('Registrar'),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () => Modular.to.navigate(HomePage.routeName),
                child: const Text('Ir para Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRegisterModal(BuildContext context) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
              TextField(
                keyboardType: TextInputType.name,
                obscureText: isObscuredPassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscuredPassword = !isObscuredPassword;
                      });
                    },
                    icon: Icon(
                      isObscuredPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              TextField(
                keyboardType: TextInputType.name,
                obscureText: isObscuredConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirme a senha',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscuredConfirmPassword = !isObscuredConfirmPassword;
                      });
                    },
                    icon: Icon(
                      isObscuredConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Registrar'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
