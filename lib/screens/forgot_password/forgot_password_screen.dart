import 'package:flutter/material.dart';

import 'components/body.dart';

// Pantalla de formulario olvide mi contrasena

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olvide la contrasena"),
      ),
      body: Body(),
    );
  }
}
