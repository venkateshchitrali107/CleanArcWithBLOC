import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/model/rick_and_morty_model.dart';
import '../../data/reposistory/rick_and_morty_repo_impl.dart';

class GetRickAndMortyList implements Usecases<List<RickAndMortyModel>, Params> {
  final RickAndMortyRepositoryImpl repo;
  GetRickAndMortyList(this.repo);
  @override
  Future<Either<Failure, List<RickAndMortyModel>>> call(Params params) async {
    return await repo.getRickAndMortyList(params);
  }
}
