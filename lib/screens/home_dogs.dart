import 'package:beautiful_dogs_test/screens/list_dogs.dart';
import 'package:beautiful_dogs_test/services/services_dogs.dart';
import 'package:flutter/material.dart';

class HomeDogs extends StatefulWidget {
  const HomeDogs({super.key});

  @override
  State<HomeDogs> createState() => _HomeDogsState();
}

class _HomeDogsState extends State<HomeDogs> {
  String? dogImage;
  bool? isLoading;
  List<String> dogHistory = [];

  Future<void> _atualizarImagem() async {
    setState(() {
      isLoading = true;
    });
    final novaImagem = await getDog();
    if (novaImagem != null) {
      setState(() {
        dogImage = novaImagem;
        dogHistory.add(novaImagem);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Random dog!',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight(500)),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 241, 239, 239),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: dogImage == null
                    ? Column(
                        key: const ValueKey('pet'),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.pets),
                          SizedBox(height: 10),
                          const Text(
                            'Clique no botão para gerar seu primeiro doguito.',
                          ),
                        ],
                      )
                    : Image.network(dogImage!, key: ValueKey(dogImage)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(width: 60),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListDogs(dogHistory: dogHistory),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    backgroundColor: isLoading == true
                        ? Colors.grey.shade400
                        : Colors.lightBlueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  child: Center(child: Text("Doguitos gerados")),
                ),
              ],
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
