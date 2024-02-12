import 'package:shop_app/face_auth/locator.dart';
import 'package:shop_app/face_auth/pages/models/user.model.dart';
import 'package:shop_app/face_auth/pages/profile.dart';
import 'package:shop_app/face_auth/pages/widgets/app_button.dart';
import 'package:shop_app/face_auth/pages/widgets/app_text_field.dart';
import 'package:shop_app/face_auth/services/camera.service.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class SignInSheet extends StatelessWidget {
  SignInSheet({Key? key, required this.user}) : super(key: key);
  final Userface user;

  final _passwordController = TextEditingController();
  final _cameraService = locator<CameraService>();

  Future _signIn(context, user) async {
    if (user.password == _passwordController.text) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(

                  )));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Wrong password!'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'Welcome back, ' + user.user + '.',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                AppTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  isPassword: true,
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                AppButton(
                  text: 'LOGIN',
                  onPressed: () async {
                    _signIn(context, user);
                    user.logged = true;
                  },
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
