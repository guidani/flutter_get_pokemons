import 'package:dropdown_api/data/pokemon_repo.dart';
import 'package:dropdown_api/entity/pokemon_model.dart';

class PokemonController {
  final String endPoint;

  PokemonController({required this.endPoint});

  Future<List<Pokemon>> getAllPokemons() async {
    List<Pokemon> listOfPokemons = [];
    List responseData = await PokemonRepo(endPoint: endPoint).getPokemons();
    listOfPokemons.addAll(
      responseData.map<Pokemon>(
        (e) => Pokemon(name: e['pokemon']['name'], url: e['pokemon']['url']),
      ),
    );
    return listOfPokemons;
  }
}
