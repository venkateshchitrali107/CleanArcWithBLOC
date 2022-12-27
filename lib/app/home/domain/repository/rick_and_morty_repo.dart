import '../../data/model/rick_and_morty_model.dart';

import '../../../../core/usecases/usecases.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RickAndMortyRepository {
  Future<Either<Failure, List<RickAndMortyModel>>> getRickAndMortyList(
    Params params,
  );
}
