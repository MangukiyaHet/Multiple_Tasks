import 'dart:convert';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static APIHelper apiHelper = APIHelper._();

  Future fetchPassword(String email, String password, String version, String from) async {
    String baseUrl = "https://lmbackoffice.mycredbook.com/api_services/manage.php";

    String api = baseUrl;

    Map<String, String> requestBody = {
      'op': 'login_user',
      'email': email,
      'password': password,
      'version': version,
      'from': from,
    };

    http.Response res = await http.post(
      Uri.parse(api),
      body: requestBody,
    );

    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);
      return decodedData;
    }
    return null;
  }
}
