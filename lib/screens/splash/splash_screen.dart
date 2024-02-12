import 'package:flutter/material.dart';
import 'package:shop_app/screens/splash/components/body.dart';
import 'package:shop_app/size_config.dart';

import '../../face_auth/locator.dart';
import '../../face_auth/services/camera.service.dart';
import '../../face_auth/services/face_detector_service.dart';
import '../../face_auth/services/ml_service.dart';

// Pantalla de Splash

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MLService _mlService = locator<MLService>();
  FaceDetectorService _mlKitService = locator<FaceDetectorService>();
  CameraService _cameraService = locator<CameraService>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  _initializeServices() async {
    setState(() => loading = true);
    await _cameraService.initialize();
    await _mlService.initialize();
    _mlKitService.initialize();
    setState(() => loading = false);
  }
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
