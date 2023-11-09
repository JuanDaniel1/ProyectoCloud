import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../size_config.dart';

// Seccion de categorias

class Categories extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/images/frutasyverduras.jpg", "text": "Frutas y Verduras"},
      {"icon": "assets/images/flores.jpg", "text": "Flores"},
      {"icon": "assets/images/huevos.jpg", "text": "Huevos"},
      {"icon": "assets/images/lacteos.jpg", "text": "Lacteos"},
    ];
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Categorias",
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categories.length,
                    (index) => CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  press: () {},
                ),
              ),
            ),
          ),
        )

      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(right: 20),
    child: GestureDetector(
        onTap: press,

        child: Container(
          width: 500,
          height: 300,
          child: Stack(
            children: [
              Image.asset(icon!, fit: BoxFit.cover, width: double.infinity),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    text!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )

    ),);

  }
 
}
