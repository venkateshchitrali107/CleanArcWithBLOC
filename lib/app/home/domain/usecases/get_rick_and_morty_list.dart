import 'package:clean_arc_bloc/app/home/data/model/rick_and_morty_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/reposistory/rick_and_morty_repo_impl.dart';
import '../entity/rick_and_morty.dart';

class GetRickAndMortyList implements Usecases<List<RickAndMortyModel>, Params> {
  final RickAndMortyRepositoryImpl repo;
  GetRickAndMortyList(this.repo);
  @override
  Future<Either<Failure, List<RickAndMortyModel>>> call(Params params) async {
    return await repo.getRickAndMortyList(params);
  }
}
