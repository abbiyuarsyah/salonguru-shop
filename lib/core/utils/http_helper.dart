import 'package:http/http.dart' as http_client;

import '../enums/http_method.dart';

const baseUrl = 'https://g93902zutc.execute-api.eu-central-1.amazonaws.com/';
const apiKey = 'BxWr6VUVph4KszpHX1cCJ2MRXwERAqEj3ZhHRgiH';

class HttpClientHelper {
  const HttpClientHelper();

  Future<http_client.Response> request({
    required String endpoint,
    required HttpMethod method,
    Map<String, dynamic>? queryParameters,
  }) async {
    final url = Uri.http(
      baseUrl,
      endpoint,
      queryParameters,
    );
    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': apiKey,
    };
    final request = await _httpMethod(url, headers, method);

    return request;
  }

  Future<http_client.Response> _httpMethod(
    Uri url,
    Map<String, String> headers,
    HttpMethod method,
  ) {
    switch (method) {
      case HttpMethod.post:
        return http_client.post(url, headers: headers);
      case HttpMethod.get:
        return http_client.get(url, headers: headers);
      case HttpMethod.put:
        return http_client.put(url, headers: headers);
      case HttpMethod.delete:
        return http_client.delete(url, headers: headers);
      default:
        return http_client.get(url, headers: headers);
    }
  }
}
