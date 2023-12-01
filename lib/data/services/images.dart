import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:myfpro/data/models/images.dart';

class ShutterStockService {
  static Future<ShutterStockImages> getImages({int page = 1}) async {
    try {
      final headers = {
        'Authorization':
            'Basic TmRBTW5BazdpZ3hxOEkxZHZXeTVQc3hjSmsyWUFpV0c6VkhsdUxKSWM2S2RiRUxxMA=='
      };
      const baseUrl = "https://api.shutterstock.com";
      final response = await http.get(
        Uri.parse("$baseUrl/v2/images/search?page=$page"),
        headers: headers,
      );
      log("response: ${response.body}");
      return ShutterStockImages.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
