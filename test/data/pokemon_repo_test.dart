import 'package:dropdown_api/data/pokemon_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return a list of pokemons', () async {
    List r = await PokemonRepo(endPoint: 'normal').getPokemons();
    print(r);
  });
}
