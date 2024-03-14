import 'package:flutter/material.dart';
import 'package:shop_app/pages/populares/producto_list.dart';
import 'package:shop_app/screens/comercializadora/inicio/inicio.dart';
import 'package:shop_app/screens/comercializadora/populares/producto_list.dart';
import 'package:shop_app/screens/comercializadora/producto/producto_list.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class MenuComerc extends StatefulWidget {
  static String routeName = "/comerc1";
  const MenuComerc({super.key});

  @override
  State<MenuComerc> createState() => _MenuComercState();
}

class _MenuComercState extends State<MenuComerc> {
  int _selectDrawerItem = 0;
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeScreen();
      case 1:
        return const ProductosListComerc();
      case 2:
        return const PopularListComerc();

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
        title: const Text("Comercializadora"),
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
              title: const Text('Productos'),
              leading: const Icon(Icons.person),
              selected: (1 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: const Text('Populares'),
              leading: const Icon(Icons.wind_power_rounded),
              selected: (2 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(2);
              },
            ),
          ],
        ),
      ),
      body: getDrawerItemWidget(_selectDrawerItem),
    );
  }

}
