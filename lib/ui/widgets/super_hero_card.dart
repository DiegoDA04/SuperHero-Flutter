import 'package:flutter/material.dart';
import 'package:super_hero_flutter/data/helpers/db_helper.dart';

import '../../data/models/super_hero.dart';

class SuperHeroCard extends StatefulWidget {
  final SuperHero superHero;
  final Function(SuperHero)? removeFromFavorites;

  const SuperHeroCard({
    super.key,
    required this.superHero,
    this.removeFromFavorites,
  });

  @override
  State<SuperHeroCard> createState() => _SuperHeroCardState();
}

class _SuperHeroCardState extends State<SuperHeroCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.only(bottom: 4.0),
      color: Colors.white,
      elevation: 0.0,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.4,
            child: Image.network(
              widget.superHero.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.superHero.isFavorite
                              ? DbHelper.deleteSuperHero(widget.superHero)
                              : DbHelper.insertSuperHero(widget.superHero);

                          if (widget.removeFromFavorites != null) {
                            widget.removeFromFavorites!(widget.superHero);
                          }

                          setState(() {
                            widget.superHero.isFavorite =
                                !widget.superHero.isFavorite;
                          });
                        },
                        icon: Icon(widget.superHero.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                      )
                    ],
                  ),
                  Text(
                    widget.superHero.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(widget.superHero.fullName)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
