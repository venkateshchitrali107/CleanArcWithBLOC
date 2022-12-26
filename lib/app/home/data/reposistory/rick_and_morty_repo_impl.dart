import '../../../../core/usecases/usecases.dart';

import '../datasource/remote_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../../domain/entity/rick_and_morty.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repository/rick_and_morty_repo.dart';

class RickAndMortyRepositoryImpl implements RickAndMortyRepository {
  final RemoteDatasourceImpl dataSource;
  RickAndMortyRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<RickAndMorty>>> getRickAndMortyList(
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
