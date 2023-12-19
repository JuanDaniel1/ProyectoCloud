import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../constants.dart';
import '../models/producto_model.dart';
import '../size_config.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 60,
    this.aspectRetio = 1.02,
    this.model,
  }) : super(key: key);
  final double width, aspectRetio;
  final ProductoModel? model;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHover = false;
  Offset mousPos = new Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5 ),
      child: Card(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
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
                  arguments: ProductDetailsArguments(model: widget.model),
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
                            child: Hero(
                              tag: widget.model!.id.toString(),
                              child: Image.network(widget.model!.productoImage!, fit: BoxFit.cover,),
                            ),
                          ),




              ),
              const SizedBox(height: 10),
              Text(
                widget.model!.productoName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: getProportionateScreenWidth(18)),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Precio: \$${widget.model!.productoPrice}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
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






