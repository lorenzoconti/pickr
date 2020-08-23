import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:pickr/handlers/auth.dart';
import 'package:pickr/pages/auth.dart';
import 'package:pickr/providers/auth-provider.dart';

class MockAuth extends Mock implements BaseAuth {}

void main() {
  //
  Widget app(Widget child, BaseAuth auth) =>
      AuthProvider(auth: auth, child: MaterialApp(home: child));

  testWidgets('Empty Email and Password: Do not sign in.',
      (WidgetTester tester) async {
    //
    MockAuth mockAuth = MockAuth();
    AuthPage page = AuthPage();

    await tester.pumpWidget(app(page, mockAuth));

    await tester.tap(find.byKey(Key('login_button')));

    verifyNever(mockAuth.signInWithEmailAndPassword(email: '', password: ''));
  });

  testWidgets('Valid Email and Password: Sign in', (WidgetTester tester) async {
    //
    MockAuth mockAuth = MockAuth();
    AuthPage page = AuthPage();

    await tester.pumpWidget(app(page, mockAuth));

    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email@test.com');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('login_button')));

    verify(mockAuth.signInWithEmailAndPassword(
            email: 'email@test.com', password: 'password'))
        .called(1);
  });

  testWidgets('Invalid Email and Password: Do not sign in',
      (WidgetTester tester) async {
    //
    MockAuth mockAuth = MockAuth();
    AuthPage page = AuthPage();

    await tester.pumpWidget(app(page, mockAuth));

    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'emailtestcom');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('login_button')));

    verifyNever(mockAuth.signInWithEmailAndPassword(
        email: 'emailtestcom', password: 'password'));
  });
}
