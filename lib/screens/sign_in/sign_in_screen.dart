import 'package:flutter/material.dart';

import 'components/body.dart';

// Pagina para iniciar Sesion

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicia Sesion"),
      ),
      body: Body(),
    );
  }
}
