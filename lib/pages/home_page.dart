import 'dart:ffi';

import 'package:consulta_de_api/models/filme.dart';
import 'package:consulta_de_api/services/omdb_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  final OmdbService service = OmdbService();

  List<Filme> filmes = [];

  bool carregando = false;

  Future<void> pesquisar() async {
    setState(() {
      carregando = true;
    });

    filmes = await service.buscarFilmes(
      controller.text,
    );

    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Filmes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Digite o Filme',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: pesquisar,
                ),
              ),
            ),
            const SizedBox(height: 15),
            if (carregando) const CircularProgressIndicator(),
            Expanded(
                child: ListView.builder(
                    itemCount: filmes.length,
                    itemBuilder: (context, index) {
                      final filme = filmes[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                filme.poster != 'N/A'
                                    ? filme.poster
                                    : 'https://via.placeholder.com/100',
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filme.titulo,
                                      style: 
                                      const TextStyle(
                                        fontSize: 18,
                                        fontWeight: 
                                        FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5),
                                    Text(
                                      'Ano: ${filme.ano}',
                                    ),
                                    const SizedBox(
                                      height: 10),
                                    Text(
                                      filme.descricao,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )
                               )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
               ),
             ],
          ),
        ),
      );
    }