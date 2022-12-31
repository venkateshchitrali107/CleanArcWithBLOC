import 'package:isar/isar.dart';

part 'db.g.dart';

@collection
class RickAndMortyModelLocal {
  RickAndMortyModelLocal({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    this.type,
    this.gender,
    this.image,
    this.created,
  });

  final Id id;
  final String name;
  final String status;
  final String species;
  String? type;
  String? gender;
  String? image;
  DateTime? created;

  factory RickAndMortyModelLocal.fromJson(Map<String, dynamic> json) =>
      RickAndMortyModelLocal(
        id: json["id"] == null
            ? 1
            : int.parse(
                json["id"],
              ),
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        image: json["image"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "image": image,
        "created": created.toString(),
      };
}

class MyDatabase {
  late Isar db;
  MyDatabase() {
    db = openDB();
  }

  Isar openDB() {
    if (Isar.instanceNames.isEmpty) {
      return Isar.openSync(
        [
          RickAndMortyModelLocalSchema,
        ],
        inspector: true,
      );
    }
    return Isar.getInstance()!;
  }

  saveData(RickAndMortyModelLocal data) {
    db.writeTxnSync(
      () => db.rickAndMortyModelLocals.putSync(
        data,
      ),
    );
  }

  List<RickAndMortyModelLocal> getAll(
    int limit,
    int offset,
  ) =>
      db.rickAndMortyModelLocals
          .where()
          .offset(offset)
          .limit(limit)
          .findAllSync();
  List<RickAndMortyModelLocal> getFilteredName(
    String searchKey,
  ) =>
      db.rickAndMortyModelLocals
          .filter()
          .nameContains(
            searchKey,
            caseSensitive: false,
          )
          .findAllSync();

  List<RickAndMortyModelLocal> getFilteredStatus(
    String searchKey,
  ) =>
      db.rickAndMortyModelLocals
          .filter()
          .statusContains(
            searchKey,
            caseSensitive: false,
          )
          .findAllSync();
  List<RickAndMortyModelLocal> getFilteredSpecies(
    String searchKey,
  ) =>
      db.rickAndMortyModelLocals
          .filter()
          .speciesContains(
            searchKey,
            caseSensitive: false,
          )
          .findAllSync();

  void deleteAll() => db.writeTxnSync(
        () => db.clearSync(),
      );
}
