import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../widgets/snackbars_widget.dart';

class ApiService {
  final String apiBase = DEV_API_BASE;

  Future<Map<String, dynamic>> requestApi(
    RequestMethod method,
    String path, {
    Map<String, dynamic>? params,
    Object? body,
    Map<String, String>? headers,
    bool boolAuthToken = false,
    bool boolAuthBasic = false,
    String? iconName,
    String? flatIconToken,
      }) async {
    String apiBase = DEV_API_BASE;

    return _getAPIResponse(
      method,
      apiBase + path,
      headers ?? {},
      params: params,
      body: body,
      boolAuthToken: boolAuthToken,
    ).timeout(const Duration(seconds: 15));
  }

  Future<Map<String, dynamic>> _getAPIResponse(
      RequestMethod method,
      String urlPath,
      Map<String, String> headers, {
        Map<String, dynamic>? params,
        Object? body,
        bool boolAuthToken= false,
      }) async {


    final url = Uri.parse(urlPath);
    debugPrint("url .....$url....\n...body...$body");
    // Add authentication headers
   headers = {
     'Content-Type': 'application/json',
   };
    if (boolAuthToken) {
      headers[AUTHORIZATION] =
          BEARER + "YourAuthToken"; // Replace with logic to get auth token
    }

    http.Response response;

    try {
      switch (method) {
        case RequestMethod.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestMethod.post:
          response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          break;
        case RequestMethod.put:
          response =
              await http.put(url, headers: headers, body: jsonEncode(body));
          break;
        case RequestMethod.delete:
          response = await http.delete(url, headers: headers);
          break;
        default:
          throw Exception('Invalid request method');
      }

      return _getResponseBody(response);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Map<String, dynamic> _getResponseBody(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        // Successful response
        debugPrint("response....${jsonDecode(response.body)}");
        return jsonDecode(response.body) as Map<String, dynamic>;

      case 400:
        SnackNotification.showCustomSnackBar(
            'Bad Request: ${response.statusCode}, ${response.body}',
            isWarning: true);
        throw Exception(
            'Bad Request: ${response.statusCode}, ${response.body}');

      case 401:
        SnackNotification.showCustomSnackBar(
            'Unauthorized: ${response.statusCode}, ${response.body}',
            isWarning: true);
        throw Exception(
            'Unauthorized: ${response.statusCode}, ${response.body}');

      case 403:
        SnackNotification.showCustomSnackBar(
            'Forbidden: ${response.statusCode}, ${response.body}',
            isWarning: true);
        throw Exception('Forbidden: ${response.statusCode}, ${response.body}');

      case 404:
        SnackNotification.showCustomSnackBar(
            'Not Found: ${response.statusCode}, ${response.body}',
            isWarning: true);
        throw Exception('Not Found: ${response.statusCode}, ${response.body}');

      case 500:
        SnackNotification.showCustomSnackBar(
            'Internal Server Error: ${response.statusCode}, ${response.body}',
            isWarning: true);
        throw Exception(
            'Internal Server Error: ${response.statusCode}, ${response.body}');

      default:
        SnackNotification.showCustomSnackBar(
            'Error: ${response.statusCode}, ${response.body}',
            isWarning: true);
        throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }
}


enum RequestMethod { get, post, put, delete }
