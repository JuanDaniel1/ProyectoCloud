import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop_app/pages/categoria/categoria_list.dart';
import 'package:shop_app/pages/cliente/cliente_list.dart';
import 'package:shop_app/pages/populares/producto_list.dart';
import 'package:shop_app/pages/producto/producto_list.dart';
import 'package:shop_app/pages/inicio/inicio.dart';
import 'package:shop_app/screens/administrador/categoria/categoria_list.dart';
import 'package:shop_app/screens/administrador/populares/producto_list.dart';
import 'package:shop_app/screens/administrador/producto/producto_list.dart';
import 'package:shop_app/screens/home/home_screen.dart';



class MenuAdmin extends StatefulWidget {
  static String routeName = "/admin";

  const MenuAdmin({super.key});
  @override
  MenuAdminState createState() => MenuAdminState();
}

class MenuAdminState extends State<MenuAdmin> {

  int _selectDrawerItem = 0;
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeScreen();
      case 1:
        return const CategoriasListAdmin();
      case 2:
        return const ProductosListAdmin();
      case 3:
        return const PopularListAdmin();
    }
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SENA"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('SENA'),
              accountEmail: Text('contaco@misena.edu.co'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logoxyz.png'),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              leading: const Icon(Icons.phone),
              selected: (0 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(0);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Categorias'),
              leading: const Icon(Icons.person),
              selected: (1 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: const Text('Productos'),
              leading: const Icon(Icons.wind_power_rounded),
              selected: (2 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(2);
              },
            ),

            const Divider(),
            ListTile(
              title: const Text('Cerra Sessión'),
              leading: const Icon(Icons.touch_app_outlined),
              selected: (4 == _selectDrawerItem),
              onTap: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
            ListTile(
              title: const Text('Limpiar FaceAuth'),
              leading: const Icon(Icons.remove),
              selected: (5 == _selectDrawerItem),
              onTap: () {


              },
            ),
          ],
        ),
      ),
      body: getDrawerItemWidget(_selectDrawerItem),
    );
  }
}