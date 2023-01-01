import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../model/rick_and_morty_model.dart';
import '../local_datasource/db.dart';

abstract class RemoteDatasource {
  Future<List<RickAndMortyModel>> getRickAndMortyList(Params params);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final MyDatabase db;
  RemoteDatasourceImpl(this.db);

  @override
  Future<List<RickAndMortyModel>> getRickAndMortyList(Params params) async {
    try {
      if (params.pageNumber == 1) db.deleteAll();
      final httpLink = HttpLink('https://rickandmortyapi.com/graphql');
      final link = Link.from([httpLink]);
      final client = GraphQLClient(cache: GraphQLCache(), link: link);
      String getListQuery;
      if (params.pageNumber == 0) {
        getListQuery = '''query {
  characters(filter: { ${params.filterType.toLowerCase()}:" ${params.searchKey}"}){
    results{
      id
      name
      type
      status
      species
      gender
      
      image
      created
    }
  }
}''';
      } else {
        getListQuery = '''
  query {
  characters(page:${params.pageNumber}){
   results{
      id
      name
      type
      status
      species
      gender
      image
      created
    }
  }
}
''';
      }
      final result = await client.query(
        QueryOptions(
          document: gql(
            getListQuery,
          ),
        ),
      );
      if (result.hasException) throw ServerFailure();
      final char = result.data?["characters"];
      final data = char?['results'] as List;
      List<RickAndMortyModel> decodedList = [];
      for (var currentElement in data) {
        decodedList.add(
          RickAndMortyModel.fromJson(
            currentElement,
          ),
        );
        db.saveData(
          RickAndMortyModelLocal.fromJson(
            currentElement,
          ),
        );
      }
      return decodedList;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw ServerFailure();
    }
  }
}
