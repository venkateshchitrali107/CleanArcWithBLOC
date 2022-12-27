import 'package:clean_arc_bloc/app/home/data/model/rick_and_morty_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/entity/rick_and_morty.dart';
import '../../domain/repository/rick_and_morty_repo.dart';
import '../datasource/remote_datasource.dart';

class RickAndMortyRepositoryImpl implements RickAndMortyRepository {
  final RemoteDatasourceImpl dataSource;
  RickAndMortyRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<RickAndMortyModel>>> getRickAndMortyList(
      Params params) async {
    try {
      final result = await dataSource.getRickAndMortyList(params);
      return Right(result);
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Left(ServerFailure());
    }
  }
}
