import '../repository/rick_and_morty_repo.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

class GetRickAndMortyList implements Usecases<List<RickAndMorty>, Params> {
  @override
  Future<Either<Failure, List<RickAndMorty>>> call(Params params) async {
    return Left(ServerFailure());
  }
}
