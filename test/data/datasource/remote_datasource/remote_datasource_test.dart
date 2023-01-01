import 'package:clean_arc_bloc/core/usecases/usecases.dart';
import 'package:clean_arc_bloc/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:clean_arc_bloc/data/model/rick_and_morty_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_datasource_test.mocks.dart';

@GenerateMocks([RemoteDatasourceImpl])
void main() {
  // ignore: non_constant_identifier_names
  late MockRemoteDatasourceImpl SUT;
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
    SUT = MockRemoteDatasourceImpl();
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
