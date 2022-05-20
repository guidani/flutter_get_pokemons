import 'package:dropdown_api/controllers/pokemon_controller.dart';
import 'package:dropdown_api/entity/pokemon_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = [
    'normal',
    'fighting',
    'flying',
    'poison',
    'ground',
    'rock',
    'bug',
    'ghost',
    'steel',
    'fire',
    'water',
    'grass',
    'electric',
    'psychic',
    'ice',
    'dragon',
    'dark',
    'fairy',
    'unknown',
    'shadow'
  ];
  String? selectedItem = null;
  List<Pokemon> pokemons = [];

  Future getPokemons(String endPoint) async {
    List<Pokemon> listOfPokemon =
        await PokemonController(endPoint: endPoint).getAllPokemons();
    setState(() {
      pokemons = listOfPokemon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.green,
                Colors.yellow,
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Image.asset('images/Pokemon_logo.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Veja os pokemos pelo tipo',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildDropdown(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: pokemons.isEmpty
                      ? Image.asset('images/pikachu_img.png')
                      : _buildListPokemon(pokemons),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() => DropdownButton<String>(
        dropdownColor: Colors.green,
        isDense: true,
        isExpanded: true,
        elevation: 5,
        hint: const Text('Categorias'),
        value: selectedItem,
        onChanged: (item) {
          setState(() {
            selectedItem = item;
          });
        },
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                onTap: () => getPokemons(item),
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            )
            .toList(),
      );

  Widget _buildListPokemon(List<Pokemon> pokemons) => ListView.builder(
        itemBuilder: (context, index) {
          final currentPokemon = pokemons[index];
          String linkOfPokemon = currentPokemon.url;
          String partialNumberPokemon = linkOfPokemon.substring(34);
          String numberOfPokemon = partialNumberPokemon.substring(
              0, partialNumberPokemon.length - 1);
          return Card(
            elevation: 5,
            child: ListTile(
              leading: Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${numberOfPokemon}.png'),
              title: Text(
                currentPokemon.name,
                style: const TextStyle(
                    fontSize: 20, height: -0.5, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(currentPokemon.url),
            ),
          );
        },
        itemCount: pokemons.length,
      );
}
