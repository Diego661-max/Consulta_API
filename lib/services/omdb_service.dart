import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/filme.dart';

class OmdbService{

  final String apiKey = '7ce47bdf';

  Future<List<Filme>> buscarFilmes(String nomeFilme) async {

    List<Filme> listaFilmes = [];

    final urlBusca = 'http://www.omdbapi.com/?i=$nomeFilme&apikey=$apiKey';

    final responseBusca = await http.get(Uri.parse(urlBusca));

     final dadosBusca = json.decode(responseBusca.body);

     if(dadosBusca['Search'] != null){

      for(var item in dadosBusca['Search']){
         
        final imdbID = item['imdID'];
        
        final urlDetalhes = ' http://www.omdbapi.com/?i=$imdbID&plot=short&apikey=$apiKey';

        final responseDetalhes = await http.get(Uri.parse(urlDetalhes));

        final dadosDetalhes = json.decode(responseDetalhes.body);

        listaFilmes.add(
          Filme.fromJson(dadosDetalhes),
        );
      }
     }
    return listaFilmes;
  }
}