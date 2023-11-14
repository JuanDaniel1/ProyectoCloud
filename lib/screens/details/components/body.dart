import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/size_config.dart';

import '../../../models/producto_model.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

// Cuerpo de Detalles de cada producto

class Body extends StatelessWidget {
  final ProductoModel? model;

  const Body({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(model: model),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                model: model,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(model: model),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.15,
                              right: SizeConfig.screenWidth * 0.15,
                              bottom: getProportionateScreenWidth(40),
                              top: getProportionateScreenWidth(15),
                            ),
                            child: DefaultButton(
                              text: "Anadir a carrito",
                              press: () {},
                            ),

                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.20,
                              right: SizeConfig.screenWidth * 0.20,
                              bottom: getProportionateScreenWidth(40),
                              top: getProportionateScreenWidth(15),
                            ),
                            child: SizedBox(
                            width: double.infinity,
                            height: getProportionateScreenHeight(46),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape:
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                primary: Colors.white,
                                backgroundColor: Colors.redAccent,
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Atras",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(13),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )

                          ),
                        ],
                      )

                    ),



                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
