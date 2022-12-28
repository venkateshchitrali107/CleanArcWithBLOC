import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'db.g.dart';

class RickAndMortyModelLocal extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get type => text().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get image => text().nullable()();
  TextColumn get created => text().nullable()();
}

@DriftDatabase(tables: [RickAndMortyModelLocal])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future insert(
    newData,
  ) =>
      into(
        rickAndMortyModelLocal,
      ).insert(
        newData,
      );

  Future<List<RickAndMortyModelLocalData>> getAll(
    int limit,
    int offset,
  ) =>
      (select(rickAndMortyModelLocal)
            ..limit(
              limit,
              offset: offset,
            ))
          .get();

  void deleteAll() => delete(
        rickAndMortyModelLocal,
      ).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
