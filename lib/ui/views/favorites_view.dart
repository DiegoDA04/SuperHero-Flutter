import 'package:flutter/material.dart';
import 'package:super_hero_flutter/data/helpers/db_helper.dart';

import '../../data/models/super_hero.dart';
import '../widgets/super_hero_card.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  List<SuperHero>? superheroesDb;

  @override
  void initState() {
    super.initState();
    initalize();
  }

  initalize() async {
    superheroesDb = List.empty();
    superheroesDb = await DbHelper.fetchSuperHeroes();
    if (mounted) {
      setState(() {});
    }
  }

  void removeSuperHero(SuperHero superHero) {
    print("Hola");
    setState(() {
      superheroesDb?.remove(superHero);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(right: 20.0, top: 20.0, left: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Favorites",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: superheroesDb!.length,
                  itemBuilder: (context, index) => SuperHeroCard(
                    superHero: superheroesDb![index],
                    removeFromFavorites: removeSuperHero,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
