import 'package:flutter/material.dart';
import 'package:shop_app/models/popular_model.dart';

import '../../models/Product.dart';
import '../../models/producto_model.dart';
import 'package:shop_app/screens/detailspopular/components/body.dart';
import 'components/custom_app_bar.dart';

// Pantalla de detalles de productos

class DetailsPopularScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductPopularDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductPopularDetailsArguments;
    return Scaffold(
      body: Body(model: agrs.model),
    );
  }
}

class ProductPopularDetailsArguments {
  final PopularModel? model;

  ProductPopularDetailsArguments({required this.model});
}
