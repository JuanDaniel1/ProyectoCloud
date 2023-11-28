import 'package:flutter/material.dart';
import 'package:shop_app/escaner/models/screen_params.dart';
import 'package:shop_app/escaner/ui/detector_widget.dart';

/// [HomeView] stacks [DetectorWidget]
class HomeView extends StatelessWidget {
  static String routeName = "/escaner";
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenParams.screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      key: GlobalKey(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Escaner")
      ),
      body: const DetectorWidget(),
    );
  }
}
