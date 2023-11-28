import 'dart:convert';

List<PopularModel> popularFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<PopularModel>((json) => PopularModel.fromJson(json))
      .toList();
}

class PopularModel {
  late int? id;
  late String? productoName;
  late String? productoPrice;
  late String? productoImage;

  PopularModel({
    this.id,
    this.productoName,
    this.productoPrice,
    this.productoImage,
  });

  factory PopularModel.fromJson(Map<String, dynamic> json) {
    return PopularModel(
        id: json['id'] as int,
        productoName: json['productoName'],
        productoPrice: json['productoPrice'],
        productoImage: json['productoImagen'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productoName'] = productoName;
    data['productoPrice'] = productoPrice;
    data['productoImagen'] = productoImage;
    return data;
  }
}