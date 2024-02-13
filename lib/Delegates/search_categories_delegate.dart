
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/Delegates/search_service.dart';
import 'package:shop_app/models/productSearch.dart';
import 'package:shop_app/services/product_service.dart';

import '../components/product_card.dart';
import '../constants.dart';
import '../models/Product.dart';
import '../screens/details/details_screen.dart';
import '../screens/home/components/section_title.dart';
import '../size_config.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<dynamic> searchResults = [];

  searchDjango(value) async {
    // Limpia la lista de resultados antes de realizar una nueva búsqueda
    setState(() {
      searchResults.clear();
    });

    // Realiza la solicitud de búsqueda
    try {
      String responseBody = await SearchService.searchDjangoApi(value);
      List<dynamic> data = jsonDecode(responseBody);

      // Actualiza la lista de resultados y notifica a Flutter que debe redibujar la interfaz de usuario
      setState(() {
        searchResults.addAll(data);
      });
    } catch (e) {
      // Maneja el error de manera apropiada, como mostrar un mensaje de error al usuario
      print("Error fetching search results: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 2; // Valor predeterminado para pantallas más pequeñas

// Obtén el ancho de la pantalla utilizando MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

// Comprueba si el ancho de la pantalla es lo suficientemente grande para aumentar el crossAxisCount
    if (screenWidth > 600 && screenWidth < 1000) { // Puedes ajustar este valor según tus necesidades
      crossAxisCount = 3; // Cambia el crossAxisCount para pantallas más grandes
    } else if (screenWidth >= 1000) {
      crossAxisCount = 4;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('django Api search'),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val){
                  searchResults.clear();

                  searchDjango(val);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: "Search here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: null,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildResultCard(searchResults[index]);
                }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.7
              ),
              ),
            )

          ],
        ),
      ),
    );
  }
  Widget buildResultCard(data) {
    return Padding(
        padding: EdgeInsets.all(5 ),
        child: Card(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.green,
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0,6)
                  ),
                  BoxShadow(
                      color: Colors.green,
                      spreadRadius: -4,
                      blurRadius: 5,
                      offset: Offset(6,0)
                  )
                ]),
            child:  SizedBox(
              child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: ProductDetailsArguments(model: data)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.02,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: kSecondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.network(data['productoImage'], fit: BoxFit.cover,),

                          ),




                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            data['productoName'],
                            style: GoogleFonts.oswald(fontSize: getProportionateScreenWidth(14), fontWeight: FontWeight.w300, color: Colors.black),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "\$${data['productoPrice']}",
                                  style: GoogleFonts.oswald(fontSize: getProportionateScreenWidth(16), fontWeight: FontWeight.w400, color: kPrimaryColor)
                              ),
                            ],
                          ),
                        )


                      ],
                    ),
                  )

              ),
            ),
          ),

        )

    );
  }
}
