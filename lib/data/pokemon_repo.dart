import 'package:dio/dio.dart';

const String baseUrl = 'https://pokeapi.co/api/v2/type';

class PokemonRepo {
  var dio = Dio();

  final String endPoint;

  PokemonRepo({required this.endPoint});

  Future getPokemons() async {
    var response = await dio.get("$baseUrl/$endPoint");
    if (response.statusCode == 200) {
      return response.data['pokemon'];
    }
  }
}
