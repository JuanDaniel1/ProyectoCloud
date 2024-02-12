import 'package:http/http.dart' as http;

class SearchService {
  static Future<String> searchDjangoApi(String query) async {
    String url = 'http://192.168.1.59/api/producto/?search=$query';

    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    return response.body;
  }
}