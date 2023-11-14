import 'package:flutter/material.dart';

class jefe extends StatelessWidget {
  static String routeName = "/jefe";
  const jefe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jefe"),),body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bienvenido rol Jefe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        )

    );
  }
}
