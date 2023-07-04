import 'package:flutter/material.dart';
import 'package:super_hero_flutter/data/helpers/db_helper.dart';
import 'package:super_hero_flutter/data/helpers/http_helper.dart';
import 'package:super_hero_flutter/data/models/super_hero.dart';
import 'package:super_hero_flutter/ui/widgets/super_hero_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();
  List<SuperHero>? superHeroes;

  @override
  void initState() {
    super.initState();
    superHeroes = List.empty();
  }

  Future<void> getSuperHeroesByName(String name) async {
    List<SuperHero> dbItems = await DbHelper.fetchSuperHeroes();

    superHeroes = await HttpHelper.fetchSuperHeroesByName(name);

    for (var heroFromDb in dbItems) {
      int heroIndex =
          superHeroes!.indexWhere((element) => element.id == heroFromDb.id);
      if (heroIndex != -1) {
        superHeroes![heroIndex].isFavorite = heroFromDb.isFavorite;
      }
    }
    if (mounted) {
      setState(() {});
    }
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
                "SuperHero API",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextField(
                textInputAction: TextInputAction.search,
                controller: searchController,
                onSubmitted: (value) async {
                  await getSuperHeroesByName(value);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 12.0),
                  hintText: "Search by name",
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 184, 181, 181),
                      fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 247, 244, 244),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: superHeroes!.length,
                  itemBuilder: (context, index) => SuperHeroCard(
                    superHero: superHeroes![index],
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
