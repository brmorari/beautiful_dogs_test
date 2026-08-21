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

class _MainAppState extends State<MainApp> {
  String? dogImage;
  bool? isLoading;

  Future<void> _atualizarImagem() async {
    setState(() {
      isLoading = true;
    });
    final novaImagem = await getDog();
    if (novaImagem != null) {
      setState(() {
        dogImage = novaImagem;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 239, 239),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 100),
              Text(
                'Random Dog!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight(550)),
              ),
              Expanded(
                child: Center(
                  child: dogImage == null
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.pets),
                            SizedBox(height: 10),
                            const Text(
                              'Clique no botão para gerar seu primeiro doguito.',
                            ),
                          ],
                        )
                      : Image.network(dogImage!),
                ),
              ),
              ElevatedButton(
                onPressed: isLoading == true ? null : _atualizarImagem,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: isLoading == true
                      ? Colors.grey.shade400
                      : Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                child: isLoading == true
                    ? const SizedBox(
                        height: 20,
                        width: 88,
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Text('Gerar Doguito'),
              ),
              SizedBox(height: 80),
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
