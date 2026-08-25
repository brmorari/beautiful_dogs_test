import 'package:http/http.dart' as http;

import 'dart:convert';

Future<String?> getDog() async {
  final url = Uri.parse('https://dog.ceo/api/breeds/image/random');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String dogImage = data['message'];
      return dogImage;
    } else {
      print('Erro na API');
    }
  } catch (e) {
    print('Erro de conexão: $e');
  }
  return null;
}
