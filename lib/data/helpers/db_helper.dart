import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:super_hero_flutter/data/models/super_hero.dart';

class DbHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE super_heroes(
      id TEXT PRIMARY KEY NOT NULL,
      name TEXT,
      image_url TEXT,
      full_name TEXT,
      is_favorite INTEGER
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('superherodb', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<void> insertSuperHero(SuperHero superHero) async {
    final db = await DbHelper.db();
    await db.insert('super_heroes', superHero.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<SuperHero>> fetchSuperHeroes() async {
    final db = await DbHelper.db();

    final data = await db.query('super_heroes', orderBy: "id");

    return data.map((e) => SuperHero.fromDbMap(e)).toList();
  }

  static Future<void> deleteSuperHero(SuperHero superHero) async {
    final db = await DbHelper.db();
    try {
      await db
          .delete('super_heroes', where: "id = ?", whereArgs: [superHero.id]);
    } catch (err) {
      debugPrint("Algo paso mano u.u: $err");
    }
  }
}
