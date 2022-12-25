import 'package:clean_arc_bloc/app/home/data/reposistory/rick_and_morty_repo_impl.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import '../entity/rick_and_morty.dart';

class GetRickAndMortyList implements Usecases<List<RickAndMorty>, Params> {
  @override
  Future<Either<Failure, List<RickAndMorty>>> call(Params params) async {
    return await RickAndMortyRepositoryImpl().getRickAndMortyList(params);
  }
}
