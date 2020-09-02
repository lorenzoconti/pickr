import 'package:flutter/material.dart';

import 'package:pickr/enums/auth_mode.dart';
import 'package:pickr/providers/auth-provider.dart';
import 'package:pickr/providers/game-provider.dart';
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

  /// Validates the form.
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// Validates and submits the form.
  ///
  /// If the form is right validated, it invokes the signIn or createUser method
  /// and waits for the result.
  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final auth = AuthProvider.of(context).auth;

        if (_mode == AuthMode.LOGIN) {
          final result = await auth.signInWithEmailAndPassword(
              email: _email, password: _password);
          callback(result);
        } else {
          final result = await auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          callback(result);
        }
      } catch (e) {
        await showDialog(context: context, child: Text(e.toString()));
      }
    }
  }

  /// Set of actions to be done after the validation.
  ///
  /// Starts fetching the informations in order to create the game options page
  /// and then navigates to that page.
  void callback(String user) {
    //
    var game = GameProvider.of(context).game;

    if (user != null) {
      game
          .fetch()
          .then((value) => Navigator.of(context).pushReplacementNamed('/home'));
    } else {
      showDialog(context: context, child: Text('error'));
    }
  }

  /// Switches from login auth mode to register auth mode.
  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _mode = AuthMode.SIGNIN;
    });
  }

  /// Switches from register auth mode to login auth mode.
  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _mode = AuthMode.LOGIN;
    });
  }

  /// Builds the auth page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text('Pickr Login'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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

  /// Builds the form fields.
  List<Widget> buildInputs() {
    var myFocusNode = FocusNode();
    return <Widget>[
      TextFormField(
        cursorColor: Colors.green.shade600,
        key: Key('email'),
        decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? Colors.blue : Colors.black),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green))),
        validator: EmailFieldValidator.validate,
        onSaved: (String value) => _email = value,
      ),
      TextFormField(
        focusNode: myFocusNode,
        cursorColor: Colors.green.shade600,
        key: Key('password'),
        decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? Colors.blue : Colors.black),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green))),
        obscureText: true,
        validator: PasswordFieldValidator.validate,
        onSaved: (String value) => _password = value,
      ),
    ];
  }

  /// Builds the submit button and the switch auth mode button.
  List<Widget> buildSubmitButtons() {
    if (_mode == AuthMode.LOGIN) {
      return <Widget>[
        GestureDetector(
          onTap: validateAndSubmit,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade300),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
            key: Key('login_button'),
            child: Center(child: Text('Login', style: TextStyle(fontSize: 18))),
          ),
        ),
        Container(
          margin: EdgeInsets.all(15),
          child: Center(
            child: Text("Don't you have an account?"),
          ),
        ),
        FlatButton(
          key: Key('login_to_create'),
          child: Text('Create an account', style: TextStyle(fontSize: 18)),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return <Widget>[
        GestureDetector(
          onTap: validateAndSubmit,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade300),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
            key: Key('create_account'),
            child: Center(
                child:
                    Text('Create an account', style: TextStyle(fontSize: 18))),
          ),
        ),
        FlatButton(
          key: Key('create_to_login'),
          child: Text('Have an account? Login', style: TextStyle(fontSize: 18)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
