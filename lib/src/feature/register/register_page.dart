import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/core/widgets/app_loading.dart';
import 'package:pets_adventure_frontend/src/core/widgets/app_snack_bar.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/register/dto/register_dto.dart';
import 'package:pets_adventure_frontend/src/feature/register/state/register_state.dart';
import 'package:pets_adventure_frontend/src/feature/register/store/register_store.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const routeName = '/register/';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isObscuredPassword = true;
  bool isObscuredConfirmPassword = true;
  final register = RegisterDto();

  @override
  void initState() {
    context.read<RegisterStore>().observer(
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
          onState: (state) => {
            if (state is Registered)
              {
                showSnackBar(
                    context, state.response.success, SnackBarEnum.success),
              }
          },
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RegisterStore>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: register.setEmail,
                validator: (value) => register.email.validate(),
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  errorMaxLines: 2,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: register.setPassword,
                validator: (value) => register.password.validate(),
                keyboardType: TextInputType.name,
                obscureText: isObscuredPassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Senha',
                  errorMaxLines: 2,
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
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: register.setConfirmPassword,
                validator: (value) =>
                    register.confirmPassword.validate(register.password.value),
                keyboardType: TextInputType.name,
                obscureText: isObscuredConfirmPassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Confirme a senha',
                  errorMaxLines: 2,
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
                onPressed: () async {
                  final validate = register.validate();
                  if (validate == null) {
                    await store.register(register);
                  } else {
                    store.showError(validate);
                  }
                },
                child: const Text('Registrar'),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  Modular.dispose<RegisterStore>();
                  Modular.to.navigate(LoginPage.routeName);
                },
                child: const Text('Fazer login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
