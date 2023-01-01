import 'package:clean_arc_bloc/data/datasource/local_datasource/db.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'db_test.mocks.dart';

@GenerateMocks([MyDatabase])
void main() {
  late MockMyDatabase db;
  List<RickAndMortyModelLocal> allMockData = [
    RickAndMortyModelLocal(
      id: 1,
      name: "Rick",
      status: "Alive",
      species: "Human",
    ),
    RickAndMortyModelLocal(
      id: 2,
      name: "Ricks",
      status: "dead",
      species: "Human",
    ),
    RickAndMortyModelLocal(
      id: 3,
      name: "Ric",
      status: "unkown",
      species: "Alien",
    ),
    RickAndMortyModelLocal(
      id: 4,
      name: "RickAndMorty",
      status: "Alive",
      species: "Human",
    ),
  ];
  List<RickAndMortyModelLocal> statusAliveMockData = [
    RickAndMortyModelLocal(
      id: 1,
      name: "Rick",
      status: "Alive",
      species: "Human",
    ),
    RickAndMortyModelLocal(
      id: 4,
      name: "RickAndMorty",
      status: "Alive",
      species: "Human",
    ),
  ];
  setUp(() {
    db = MockMyDatabase();
  });

  test("get all data", () async {
    when(
      db.getAll(
        20,
        20,
      ),
    ).thenAnswer(
      (_) => allMockData,
    );
    final result = db.getAll(
      20,
      20,
    );
    verify(
      db.getAll(
        20,
        20,
      ),
    );

    expect(
      result.length,
      4,
    );
  });

  test("get named filter data", () async {
    when(
      db.getFilteredName(
        "Rick",
      ),
    ).thenAnswer(
      (_) => statusAliveMockData,
    );
    final result = db.getFilteredName(
      "Rick",
    );
    verify(
      db.getFilteredName(
        "Rick",
      ),
    );

    expect(
      result.length,
      2,
    );
  });

  test("get status filter data", () async {
    when(
      db.getFilteredStatus(
        "Alive",
      ),
    ).thenAnswer(
      (_) => statusAliveMockData,
    );
    final result = db.getFilteredStatus(
      "Alive",
    );
    verify(
      db.getFilteredStatus(
        "Alive",
      ),
    );

    expect(
      result.length,
      2,
    );

    expect(
      result.first.status,
      equals(
        "Alive",
      ),
    );
  });
}
