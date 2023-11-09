import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 60,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);
  final double width, aspectRetio;
  final Product product;

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
                      spreadRadius: 4,
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
                  arguments: ProductDetailsArguments(product: widget.product),
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
                              tag: widget.product.id.toString(),
                              child: Image.asset(widget.product.images[0]),
                            ),
                          ),




              ),
              const SizedBox(height: 10),
              Text(
                widget.product.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Precio: \$${widget.product.price}",
                    style: TextStyle(
                      fontSize: 25,
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






