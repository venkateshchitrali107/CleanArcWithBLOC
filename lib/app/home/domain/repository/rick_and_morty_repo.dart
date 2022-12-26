import '../../../../core/usecases/usecases.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entity/rick_and_morty.dart';

abstract class RickAndMortyRepository {
  Future<Either<Failure, List<RickAndMorty>>> getRickAndMortyList(
    Params params,
  );
}
