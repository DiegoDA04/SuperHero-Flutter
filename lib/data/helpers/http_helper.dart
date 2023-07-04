import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/super_hero.dart';

class HttpHelper {
  static const String accessToken = '6573649486027017';
  static const String baseUrl =
      "https://www.superheroapi.com/api.php/$accessToken";

  static Future<List<SuperHero>> fetchSuperHeroesByName(String name) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/search/$name'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (jsonDecode(response.body)['response'] == "success") {
      return (jsonDecode(response.body)['results'] as List)
          .map((e) => SuperHero.fromJson(e))
          .toList();
    } else {
      return List.empty();
    }
  }

  static Future<SuperHero> fetchSuperHeroById(String id) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return SuperHero.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load super hero');
    }
  }
}
