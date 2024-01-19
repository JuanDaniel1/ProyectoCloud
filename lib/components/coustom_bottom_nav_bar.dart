import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/chatbot/chatbotscreen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/informacion/pag2_informacion.dart';
import 'package:shop_app/screens/informacion/pag_informacion.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/components/sign_form.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/usuario.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({Key? key, required this.selectedMenu}) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Colors.black87;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.green[200],
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? inActiveIconColor
                      : kPrimaryColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/info.svg",
                  color: MenuState.favourite == selectedMenu
                      ? inActiveIconColor
                      : kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Carousel.routeName);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Chat bubble Icon.svg",
                  color: MenuState.message == selectedMenu
                      ? inActiveIconColor
                      : kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ChatBot.routeName);
                },
              ),
              FutureBuilder<User?>(
                  future: FirebaseAuth.instance.authStateChanges().first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final User? user = snapshot.data;
                      if (user != null) {
                        return IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/User Icon.svg",
                              color: MenuState.profile == selectedMenu
                                  ? inActiveIconColor
                                  : kPrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ProfileScreen.routeName);
                            });
                      } else {
                        return IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/User Icon.svg",
                              color: MenuState.profile == selectedMenu
                                  ? inActiveIconColor
                                  : kPrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            }
                            // El usuario no ha iniciado sesión

                            );
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          )),
    );
  }
}
