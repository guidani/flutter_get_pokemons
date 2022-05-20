import 'package:dropdown_api/controllers/pokemon_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('pokemon controller should return a list of pokemon', () async {
    var r = await PokemonController(endPoint: 'normal').getAllPokemons();
    print(r[0].name);
    print(r[0].url);
  });
}
