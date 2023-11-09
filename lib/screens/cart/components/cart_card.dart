

import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

// Card de cada producto en carro de compras

class CartCard extends StatefulWidget {
  const CartCard({super.key, required this.cart});
  final Cart cart;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    double subtotal = widget.cart.product.price * widget.cart.numOfItem;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: getProportionateScreenWidth(100),
          height: getProportionateScreenWidth(80),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(widget.cart.product.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cart.product.title,
              style: TextStyle(color: Colors.black, fontSize: getProportionateScreenWidth(14)),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${widget.cart.product.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor, fontSize: getProportionateScreenWidth(14)),
                children: [
                  TextSpan(
                      text: " x${widget.cart.numOfItem}",
                      style: TextStyle(fontSize: getProportionateScreenWidth(12))),
                ],
              ),
            )
          ],
        ),
        Column(
          children: [
            Text("SubTotal", style: TextStyle(fontSize: getProportionateScreenWidth(14)),),
            Text("\$${subtotal}", style: TextStyle(fontSize: getProportionateScreenWidth(16), fontWeight: FontWeight.bold),)
          ],
        )
      ],
    );
  }
}
