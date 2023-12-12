
import 'package:flutter/material.dart';
import 'package:shop_app/models/productSearch.dart';
import 'package:shop_app/services/product_service.dart';

import '../components/product_card.dart';
import '../models/Product.dart';
import '../screens/home/components/section_title.dart';
import '../size_config.dart';

class SearchCategoriesDelegate extends SearchDelegate{







  @override
  String get searchFieldLabel => 'Busca tu Producto ';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
          onPressed: () => this.query= '',
          icon: Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(
          onPressed: () => this.close(context, null),
          icon: Icon(Icons.arrow_back_ios)
      );
  }

  @override
  Widget buildResults(BuildContext context) {

    if ( query.trim().length == 0){
      return Text('No hay valor en el query');
    }

    final productService = new ProductService();

    return FutureBuilder<List<Producto>>(
        future: productService.getProductByName( query ),
        builder: ( _  , AsyncSnapshot<List<Producto>> snapshot) {
          if( snapshot.hasData ){
            //crear la lista
            return _showProducts( snapshot.data! );
          } else {
            //cargando
            return Center(child: CircularProgressIndicator(strokeWidth: 4));
          }
        },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(title: Text('Sugerencias'),);
  }
  Widget _showProducts ( List<Producto> productos1 ) {
    return ListView.builder(
      itemCount: productos1.length,
      itemBuilder: ( _ , i){
        final producto = productos1[i];
        return ListTile(
          title: Text(producto.productoName),
          subtitle: Text(producto.productoCategoria),
          trailing: Text(producto.productoPrice),
        );
      }
    );


  }
}