import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/model/rick_and_morty_model.dart';

abstract class RickAndMortyRepository {
  Future<Either<Failure, List<RickAndMortyModel>>> getRickAndMortyList(
    Params params,
  );
  Future<Either<Failure, List<RickAndMortyModel>>> getFilteredRickAndMortyList(
    Params params,
  );
}
