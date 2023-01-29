import 'package:flutter/material.dart';
import 'package:products_app/src/providers/providers.dart';
import 'package:products_app/src/services/services.dart';
import 'package:products_app/src/ui/input_decoration.dart';
import 'package:products_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterLoginScreen extends StatelessWidget {
  const RegisterLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 250),
              CardContainer(
                  child: Column(children: [
                const SizedBox(height: 30),
                const Text(
                  'Create Account',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 22),
                ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: const _LoginForm())
              ])),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              cursorColor: Colors.indigo,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'johanny-94-@hotmail.com',
                labelStyle: 'Email or Username',
                prefixIcon: Icons.email_rounded,
              ),
              onChanged: ((value) => loginForm.email = value),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'The value entered is not an email';
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              cursorColor: Colors.indigo,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelStyle: 'Password',
                prefixIcon: Icons.lock,
              ),
              onChanged: ((value) => loginForm.password = value),
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'Password must be 6 characters';
              },
            ),
            const SizedBox(height: 50),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.indigo,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);
                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'Home');
                      } else {
                        //MOSTRAR ERROR EN PANTALLA
                        loginForm.isLoading = false;
                      }
                    },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  child: Text(loginForm.isLoading ? '¡Wait!' : 'Sign In',
                      style: const TextStyle(color: Colors.white))),
            ),
            const SizedBox(height: 50),
            Row(
              children: const <Widget>[
                Expanded(
                    child: Divider(
                        thickness: 1, height: 1, color: Colors.black12)),
                SizedBox(width: 12),
                Text('or',
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
                SizedBox(width: 13),
                Expanded(
                    child:
                        Divider(thickness: 1, height: 1, color: Colors.black12))
              ],
            ),
            const SizedBox(height: 22),
            TextButton(
                onPressed: (() =>
                    Navigator.pushReplacementNamed(context, 'Login')),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.indigo.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(const StadiumBorder())),
                child: const Text(
                  '¿You have an account?',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                )),
          ],
        ));
  }
}
