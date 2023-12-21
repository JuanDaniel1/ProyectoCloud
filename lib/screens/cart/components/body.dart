import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/cart/cart_screen.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../models/carrito_model.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

// Cuerpo de carrito de compras

class Body extends StatefulWidget {
  const Body({super.key, this.cart});
  final CarritoModel? cart;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
    return FutureBuilder<List<CarritoModel>>(
        future: fetchPopularData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Puedes mostrar un indicador de carga mientras se espera la respuesta.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No se encontraron datos');
          } else {
            double total = snapshot.data!
                .map((carrito) => double.parse(carrito.carritoSubtotal!))
                .fold(0, (a, b) => a + b);
            return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Dismissible(
                            key: Key(snapshot.data![index].toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              await snapshot.data![index].deleteCarrito();
                              setState(() {
                                snapshot.data!.removeAt(index);
                              });
                              Navigator.pushReplacementNamed(context, CartScreen.routeName);
                            },
                            background: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE6E6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  SvgPicture.asset("assets/icons/Trash.svg"),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: getProportionateScreenWidth(100),
                                  height: getProportionateScreenWidth(80),
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          getProportionateScreenWidth(10)),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                          snapshot.data![index].carritoImagen!),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].carritoNombre!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenWidth(14)),
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 10),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            "\$${snapshot.data![index].carritoPrecioUnitario}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    14)),
                                        children: [
                                          TextSpan(
                                              text:
                                                  " x${snapshot.data![index].carritoCantidad}",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          12))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        "SubTotal",
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    14)),
                                      ),
                                    ),
                                    Text(
                                      "\$${snapshot.data![index].carritoSubtotal}",
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(16),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenWidth(15),
                        horizontal: getProportionateScreenWidth(30),
                      ),
                      // height: 174,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, -15),
                            blurRadius: 20,
                            color: Color(0xFFDADADA).withOpacity(0.15),
                          )
                        ],
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: getProportionateScreenWidth(40),
                                  width: getProportionateScreenWidth(40),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SvgPicture.asset(
                                      "assets/icons/receipt.svg"),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(20)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Total:\n",
                                    children: [
                                      TextSpan(
                                        text: "\$${total}",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(190),
                                  child: DefaultButton(
                                    text: "Comprar",
                                    press: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          }
        });
  }
}
