import 'package:http/http.dart' as http_client;

import '../enums/http_method.dart';

const baseUrl = 'g93902zutc.execute-api.eu-central-1.amazonaws.com';
const apiKey = '2XyCVKIz277ZMEirPNTyQ3814iBXY5rg9ddTfX4W';

class HttpClientHelper {
  const HttpClientHelper();

  Future<http_client.Response> request({
    required String endpoint,
    required HttpMethod method,
    Map<String, dynamic>? queryParameters,
    Object? body,
  }) async {
    final url = Uri.https(
      baseUrl,
      endpoint,
      queryParameters,
    );
    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': apiKey,
    };

    final request = await _httpMethod(url, headers, method, body);

    return request;
  }

  Future<http_client.Response> _httpMethod(
    Uri uri,
    Map<String, String> headers,
    HttpMethod method,
    Object? body,
  ) {
    switch (method) {
      case HttpMethod.post:
        return http_client.post(uri, headers: headers, body: body);
      case HttpMethod.get:
        return http_client.get(uri, headers: headers);
      case HttpMethod.put:
        return http_client.put(uri, headers: headers);
      case HttpMethod.delete:
        return http_client.delete(uri, headers: headers);
      default:
        return http_client.get(uri, headers: headers);
    }
  }
}
