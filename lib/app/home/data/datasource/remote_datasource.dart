import '../../../../core/usecases/usecases.dart';
import '../model/rick_and_morty_model.dart';
import '../../domain/entity/rick_and_morty.dart';
import '../../../../core/error/failure.dart';
import 'package:graphql/client.dart';

abstract class RemoteDatasource {
  Future<List<RickAndMorty>> getRickAndMortyList(Params params);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  @override
  Future<List<RickAndMorty>> getRickAndMortyList(Params params) async {
    try {
      final httpLink = HttpLink('https://rickandmortyapi.com/graphql');
      final link = Link.from([httpLink]);
      final client = GraphQLClient(cache: GraphQLCache(), link: link);
      final getList = '''
  query {
  characters(page:${params.pageNumber}){
    results{
      id
      name
      type
      status
      species
    }
  }
}
''';
      final result = await client.query(QueryOptions(document: gql(getList)));
      if (result.hasException) throw ServerFailure();
      final char = result.data?["characters"];
      final data = char?['results'] as List;
      List<RickAndMorty> decodedList = [];
      for (var currentElement in data) {
        decodedList.add(RickAndMortyModel.fromJson(currentElement));
      }
      return decodedList;
    } catch (e) {
      print(e.toString());
      throw ServerFailure();
    }
  }
}
