import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

String? dogImage;

class _MainAppState extends State<MainApp> {
  Future<void> _atualizarImagem() async {
    final novaImagem = await getDog();
    if (novaImagem != null) {
      setState(() {
        dogImage = novaImagem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: dogImage == null
                      ? const Text('Clique no botão para gerar um cachorro')
                      : Image.network(dogImage!),
                ),
              ),
              ElevatedButton(
                onPressed: _atualizarImagem,
                child: Text('Gerar Doguito'),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

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
