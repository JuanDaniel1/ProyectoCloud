import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';

import '../../models/carrito_model.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:http/http.dart' as http;

// Pantalla de carro de compras

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  Future<List<CarritoModel>> fetchPopularData() async {
    final response =
    await http.get(Uri.parse('http://192.168.1.59/api/carrito/'));

    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON y mapear a instancias de PopularModel
      List<CarritoModel> carritoList = carritoFromJson(response.body);
      // Puedes imprimir el total si lo necesitas
      return carritoList;
    } else {
      // Si la solicitud no fue exitosa, lanzar una excepción o manejar el error según sea necesario
      throw Exception('Error al cargar datos desde la API');
    }
  }

  void main() async {
    try {
      List<CarritoModel> popularData = await fetchPopularData();

      // Hacer algo con los datos obtenidos, por ejemplo, imprimirlos
      print('Datos del carrito: $popularData');
      // Hacer algo con los datos obtenidos, por ejemplo, imprimirlos
      print(popularData);
    } catch (e) {
      // Manejar el error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchPopularData(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    // Muestra un indicador de carga mientras se obtienen los datos
    return CircularProgressIndicator();
    } else if (snapshot.hasError) {
    // Muestra un mensaje de error si la obtención de datos falla
    return Text('Error: ${snapshot.error}');
    } else {
    // Si los datos se obtienen correctamente, actualiza la lista de elementos del carrito

    return Scaffold(
    appBar: AppBar(
    title: Column(
    children: [
    Text(
    "Carrito de Compras",
    style: TextStyle(color: Colors.black),
    ),
    Text(
    "${snapshot.data!.length} items",
    style: Theme.of(context).textTheme.caption,
    ),
    ],
    ),
    ),
    body: Body(),
    );
    }});
    }

}


