import 'package:flutter/material.dart';

import '../../../models/popular_model.dart';
import '../../../size_config.dart';
import 'section_title.dart';
import 'package:http/http.dart' as http;

// Seccion de productos populares

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  Future<List<PopularModel>> fetchPopularData() async {
    final response = await http.get(Uri.parse('http://192.168.1.59/api/producto-popular/'));

    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON y mapear a instancias de PopularModel
      List<PopularModel> popularList = popularFromJson(response.body);
      return popularList;
    } else {
      // Si la solicitud no fue exitosa, lanzar una excepción o manejar el error según sea necesario
      throw Exception('Error al cargar datos desde la API');
    }
  }
  void main() async {
    try {
      List<PopularModel> popularData = await fetchPopularData();
      // Hacer algo con los datos obtenidos, por ejemplo, imprimirlos
      print(popularData);
    } catch (e) {
      // Manejar el error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopularModel>>(
      future: fetchPopularData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Puedes mostrar un indicador de carga mientras se espera la respuesta.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No se encontraron datos');
        } else {
          // Construir dinámicamente la lista de SpecialOfferCard
          List<SpecialOfferCard> offerCards = snapshot.data!
              .map((popularModel) => SpecialOfferCard(
            image: popularModel.productoImage!,
            category: popularModel.productoName!,
            numOfBrands: int.parse(popularModel.productoPrice!),
            press: () {
              // Acción al hacer clic en la tarjeta (puedes dejarlo vacío o agregar acciones según tu necesidad)
            },
          ))
              .toList();

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(
                  title: "Populares",
                  press: () {},
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...offerCards, // Usar el operador spread para agregar las tarjetas a la lista
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          height: getProportionateScreenWidth(180),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "\$$numOfBrands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
