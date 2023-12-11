import 'dart:convert';
import 'package:http/http.dart' as http;






// configuracion para el carrito
List<CarritoModel>carritoFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<CarritoModel>((json) => CarritoModel.fromJson(json))
      .toList();
}
class CarritoModel {
  late int? carritoId;
  late String? carritoNombre;
  late String? carritoImagen;
  late String? carritoPrecioUnitario;
  late String? carritoCantidad;
  late String? carritoSubtotal;


  Future<void> deleteCarrito() async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.1.59/api/carrito/${carritoId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // El carrito se eliminó exitosamente
        print('Carrito eliminado exitosamente');
      } else {
        // La eliminación del carrito falló
        print('Error al eliminar el carrito. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar errores de conexión u otros errores
      print('Error al eliminar el carrito: $e');
    }
  }

  CarritoModel({
    this.carritoId,
    this.carritoNombre,
    this.carritoImagen,
    this.carritoPrecioUnitario,
    this.carritoCantidad,
    this.carritoSubtotal
  });

  factory CarritoModel.fromJson(Map<String, dynamic> json) {
    return CarritoModel(
        carritoId: json['id'] as int,
        carritoNombre: json['nombre'] as String,
        carritoImagen: json['imagen'],
        carritoPrecioUnitario: json['preciounitario'],
        carritoCantidad: json['cantidad'],
        carritoSubtotal: json['subtotal']
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = carritoId;
    data['nombre'] = carritoNombre;
    data['imagen'] = carritoImagen;
    data['preciounitario'] = carritoPrecioUnitario;
    data['cantidad'] = carritoCantidad;
    data['subtotal'] = carritoSubtotal;
    return data;
  }
}