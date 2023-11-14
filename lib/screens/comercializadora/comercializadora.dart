import 'package:flutter/material.dart';

class Comercializadora extends StatelessWidget {
  static String routeName = "/comercializadora";
  const Comercializadora({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Comercializadora"),),body:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Bienvenido rol Comercializadora", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ],
    )

    );
  }
}
