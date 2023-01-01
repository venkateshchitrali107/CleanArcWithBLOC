import 'package:clean_arc_bloc/core/usecases/usecases.dart';
import 'package:clean_arc_bloc/data/datasource/local_datasource/local_datasource.dart';
import 'package:clean_arc_bloc/data/model/rick_and_morty_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_datasource_test.mocks.dart';

@GenerateMocks([LocalDatasourceImpl])
void main() {
  late MockLocalDatasourceImpl SUT;
  List<RickAndMortyModel> mockData = [
    RickAndMortyModel(
      id: "1",
      name: "Rick",
      status: "Alive",
      species: "Human",
    ),
    RickAndMortyModel(
      id: "2",
      name: "Ricks",
      status: "dead",
      species: "Human",
    ),
    RickAndMortyModel(
      id: "4",
      name: "Ric",
      status: "unkown",
      species: "Alien",
    ),
    RickAndMortyModel(
      id: "4",
      name: "RickAndMorty",
      status: "Alive",
      species: "Human",
    ),
  ];
  setUp(() {
    SUT = MockLocalDatasourceImpl();
  });

  test("checking for the page size", () {
    when(SUT.pageSize).thenAnswer(
      (realInvocation) => 20,
    );
    expect(
      SUT.pageSize,
      20,
    );
  });

  test("Checking for the function", () async {
    when(
      SUT.getRickAndMortyList(
        const Params(
          pageNumber: 1,
        ),
      ),
    ).thenAnswer(
      (_) async => mockData,
    );
    final result = await SUT.getRickAndMortyList(
      const Params(
        pageNumber: 1,
      ),
    );
    verify(
      SUT.getRickAndMortyList(
        const Params(
          pageNumber: 1,
        ),
      ),
    );
    expect(
      result,
      isA<List<RickAndMortyModel>>(),
    );

    expect(
      result.length,
      4,
    );
  });
}
