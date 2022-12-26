import '../../data/reposistory/rick_and_morty_repo_impl.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import '../entity/rick_and_morty.dart';

class GetRickAndMortyList implements Usecases<List<RickAndMorty>, Params> {
  final RickAndMortyRepositoryImpl repo;
  GetRickAndMortyList(this.repo);
  @override
  Future<Either<Failure, List<RickAndMorty>>> call(Params params) async {
    return await repo.getRickAndMortyList(params);
  }
}
