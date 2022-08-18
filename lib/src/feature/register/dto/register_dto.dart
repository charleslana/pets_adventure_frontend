// ignore_for_file: sort_constructors_first

import 'package:validators/validators.dart' as validator;

class RegisterDto {
  var _email = Email('');
  void setEmail(String newEmail) => _email = Email(newEmail);
  Email get email => _email;

  var _password = Password('');
  void setPassword(String newPassword) => _password = Password(newPassword);
  Password get password => _password;

  var _confirmPassword = ConfirmPassword('');
  void setConfirmPassword(String newPassword) =>
      _confirmPassword = ConfirmPassword(newPassword);
  ConfirmPassword get confirmPassword => _confirmPassword;

  String? validate() {
    String? validate = _email.validate();
    if (validate != null) {
      return validate;
    }
    validate = _password.validate();
    if (validate != null) {
      return validate;
    }
    validate = _confirmPassword.validate(_password.value);
    if (validate != null) {
      return validate;
    }
    return null;
  }
}

class Email {
  final String value;

  Email(this.value);

  String? validate() {
    if (value.isEmpty) {
      return 'O campo email não pode ser vazio';
    }
    if (!validator.isEmail(value)) {
      return 'E-mail inválido';
    }
    return null;
  }
}

class Password {
  final String value;

  Password(this.value);

  String? validate() {
    if (value.isEmpty) {
      return 'O campo Senha não pode ser vazio';
    }
    if (value.trim().length < 6) {
      return 'A senha deve conter no mínimo 6 caracteres';
    }
    return null;
  }
}

class ConfirmPassword {
  final String value;

  ConfirmPassword(this.value);

  String? validate(String confirmPassword) {
    if (value.isEmpty) {
      return 'O campo Confirmar senha não pode ser vazio';
    }
    if (value.trim().length < 6) {
      return 'A confirmação da senha deve conter no mínimo 6 caracteres';
    }
    if (value.trim() != confirmPassword.trim()) {
      return 'As senhas digitadas estão diferentes';
    }
    return null;
  }
}
