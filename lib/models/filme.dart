import 'package:flutter/material.dart';

class Filme {

    final String titulo;
    final String ano;
    final String descricao;
    final String poster;

    Filme({

      required this.titulo,
      required this.ano,
      required this.descricao,
      required this.poster,

    });

    factory Filme.fromJson(Map<String, dynamic> json ){
      return Filme(
        titulo: json['Title'] ?? '',
        ano: json['Year'] ?? '',
        descricao: json['Plot'] ?? '',
        poster: json['Poster'] ?? '',
      );
    }

}