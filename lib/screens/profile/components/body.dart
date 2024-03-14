import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/menucomerc.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';



import '../../../menu.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

// Cuerpo de menu de perfil

class Body extends StatefulWidget {
  const Body({super.key});
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          FutureBuilder<User?>(
            future: FirebaseAuth.instance.authStateChanges().first,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final User? user = snapshot.data;
                if (user != null) {
                  if(user.email == "tutor@gmail.com") {
                    // El usuario ha iniciado sesión
                    return ProfileMenu(
                      text: "Tutor",
                      icon: "assets/icons/Settings.svg",
                      press: () async {
                        // Cerrar sesión
                        await FirebaseAuth.instance.signOut();
                        // Navegar a la pantalla de inicio de sesión
                        Navigator.pushNamed(context, MenuTutor.routeName);
                      },
                    );
                  } else if (user.email == "comerc@gmail.com"){
                    return ProfileMenu(
                      text: "Comercializadora",
                      icon: "assets/icons/Settings.svg",
                      press: () async {
                        // Cerrar sesión
                        await FirebaseAuth.instance.signOut();
                        // Navegar a la pantalla de inicio de sesión
                        Navigator.pushNamed(context, MenuComerc.routeName);
                      },
                    );
                  } else {
                    return Text('');
                  }
                } else {
                  return Text('');

                }
              } else {
                // Mostrar un indicador de carga mientras se verifica el estado de autenticación
                return CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<User?>(
            future: FirebaseAuth.instance.authStateChanges().first,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final User? user = snapshot.data;
                if (user != null) {
                  // El usuario ha iniciado sesión
                  return ProfileMenu(
                    text: "Log Out",
                    icon: "assets/icons/Log out.svg",
                    press: () async {
                      // Cerrar sesión
                      await FirebaseAuth.instance.signOut();
                      // Navegar a la pantalla de inicio de sesión
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                  );
                } else {
                  // El usuario no ha iniciado sesión
                  return ProfileMenu(
                    text: "Log In",
                    icon: "assets/icons/Log out.svg",
                    press: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                  );
                }
              } else {
                // Mostrar un indicador de carga mientras se verifica el estado de autenticación
                return CircularProgressIndicator();
              }
            },
          ),




        ],
      ),
    );
  }
}

