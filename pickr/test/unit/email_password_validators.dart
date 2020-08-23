import 'package:flutter_test/flutter_test.dart';
import 'package:pickr/utils/validators.dart';

void main() {
  //
  test('Email Validator Test', () {
    expect(EmailFieldValidator.validate(""), "EMPTY EMAIL");
    expect(EmailFieldValidator.validate("psw"), "TOO SHORT EMAIL");
    expect(EmailFieldValidator.validate("testemailcom"), "NOT A VALID EMAIL");
    expect(EmailFieldValidator.validate("test@email.com"), null);
  });

  test('Password Validator Test', () {
    expect(PasswordFieldValidator.validate(""), "EMPTY PASSWORD");
    expect(PasswordFieldValidator.validate("psw"), "TOO SHORT PASSWORD");
    expect(PasswordFieldValidator.validate("password"), null);
  });
}
