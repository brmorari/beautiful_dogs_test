import 'package:flutter/material.dart';

class ListDogs extends StatefulWidget {
  final List<String> dogHistory;
  const ListDogs({super.key, required this.dogHistory});

  @override
  State<ListDogs> createState() => _ListDogsState();
}

class _ListDogsState extends State<ListDogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Doguitos gerados',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight(500)),
        ),
      ),
      body: widget.dogHistory.isEmpty
          ? Center(child: Text('Nenhum doguito gerado ainda :('))
          : ListView.builder(
              itemCount: widget.dogHistory.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Image.network(widget.dogHistory[index]),
                );
              },
            ),
    );
  }
}
