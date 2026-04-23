import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.18.131:5000";

  static Future<Map<String, dynamic>> createBusiness({
    required String name,
    required String ntn,
    required String type,
    required String address,
    required String city,
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/business/create"),
        headers: {
          "Content-Type": "application/json",
        },
       body: jsonEncode({
  "business_name": name,
  "ntn": ntn,
  "business_type": type,
  "address": address,
  "city": city,
  "phone": phone,
}),
      );

      final data = jsonDecode(response.body);
      if (data["duplicate"] == true) {
  return {
    "status": "duplicate",
    "message": data["message"],
  };
}

      if (response.statusCode == 200) {
        return {
          "status": "success",
          "business": data["data"] != null && data["data"].length > 0
    ? data["data"][0]
    : null,
        };
      } else {
        return {
          "status": "error",
          "error": data["error"] ?? "Unknown error",
        };
      }
    } catch (e) {
      return {
        "status": "error",
        "error": e.toString(),
      };
    }
  }
}