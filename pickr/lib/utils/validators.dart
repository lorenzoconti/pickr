class EmailFieldValidator {
  //

  static String validate(String value) {
    //
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (value.isEmpty) return 'EMPTY EMAIL';
    if (value.length < 6) return 'TOO SHORT EMAIL';
    if (!emailRegExp.hasMatch(value)) return 'NOT A VALID EMAIL';

    return null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    if (value.isEmpty) return 'EMPTY PASSWORD';
    if (value.length < 6) return 'TOO SHORT PASSWORD';
    return null;
  }
}
