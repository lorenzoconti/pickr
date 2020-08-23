import 'package:flutter/material.dart';

import 'package:pickr/enums/auth_mode.dart';
import 'package:pickr/handlers/auth.dart';
import 'package:pickr/providers/auth-provider.dart';
import 'package:pickr/utils/validators.dart';

class AuthPage extends StatefulWidget {
  AuthPage();

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  AuthMode _mode = AuthMode.LOGIN;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        // bool success = await widget.model.signIn(email: _email, password: _password, mode: _mode);

        if (_mode == AuthMode.LOGIN) {
          final String result = await auth.signInWithEmailAndPassword(
              email: _email, password: _password);
          callback(result);
        } else {
          final String result = await auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          callback(result);
        }
      } catch (e) {
        print('Error: $e');
        showDialog(context: context, child: Text(e.toString()));
      }
    }
  }

  void callback(String user) {
    if (user != null)
      Navigator.of(context).pushReplacementNamed('/home');
    else
      showDialog(context: context, child: Text("error"));
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _mode = AuthMode.SIGNIN;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _mode = AuthMode.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter login demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return <Widget>[
      TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        validator: EmailFieldValidator.validate,
        onSaved: (String value) => _email = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: PasswordFieldValidator.validate,
        onSaved: (String value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_mode == AuthMode.LOGIN) {
      return <Widget>[
        RaisedButton(
          key: Key('login_button'),
          child: Text('Login', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return <Widget>[
        RaisedButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child:
              Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}