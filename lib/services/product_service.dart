
import 'package:dio/dio.dart';

import '../models/productSearch.dart';

class ProductService{

  final _dio = new Dio();

  Future<List<Producto>> getProductByName(String productoName) async{

    try{
      final url = 'http://192.168.1.59/productos/?search=$productoName';
      final resp = await _dio.get(url);

      final List<dynamic> productoList = resp.data;
      return productoList.map(
          (obj) => Producto.fromJson(obj)
      ).toList();


    }catch (e){

      print(e);

      return[];
  }

  }
}