


import 'package:flutter/material.dart';

import '../components/product_card.dart';
import '../models/Product.dart';
import '../screens/home/components/section_title.dart';
import '../size_config.dart';

class SearchCategoriesDelegate extends SearchDelegate{



  final List<Product> demopProducts;

  List<Product> _filter =[];

  SearchCategoriesDelegate(this.demopProducts);



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
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder:(_,index){
          return ListTile(
            title: Text(_filter[index].title),
          );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter=demoProducts.where((element){
      return element.title.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder:(_,index){
          return ListTile(
            title: Text(_filter[index].title),
          );
        }
    );


  }
}