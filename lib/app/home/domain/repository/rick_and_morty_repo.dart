import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RickAndMorty {
  Future<Either<Failure, List<RickAndMorty>>> getRickAndMortyList();
}
