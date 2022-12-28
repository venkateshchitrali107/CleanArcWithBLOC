import 'package:connectivity_plus/connectivity_plus.dart';

import '../datasource/local_datasource/local_datasource.dart';

import '../../../../core/network/network_info.dart';
import '../model/rick_and_morty_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/repository/rick_and_morty_repo.dart';
import '../datasource/remote_datasource/remote_datasource.dart';

class RickAndMortyRepositoryImpl implements RickAndMortyRepository {
  final RemoteDatasourceImpl remoteDataSource;
  final LocalDatasourceImpl localDataSource;
  final NetworkInfoImpl networkInfo;
  RickAndMortyRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<RickAndMortyModel>>> getRickAndMortyList(
      Params params) async {
    try {
      final result = networkInfo.isConnected == ConnectivityResult.none
          ? await localDataSource.getRickAndMortyList(
              params,
            )
          : await remoteDataSource.getRickAndMortyList(
              params,
            );
      return Right(
        result,
      );
    } catch (error) {
      if (kDebugMode) {
        print(
          error.toString(),
        );
      }
      return Left(
        networkInfo.isConnected == ConnectivityResult.none
            ? LocalCacheFailure()
            : ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, List<RickAndMortyModel>>> getFilteredRickAndMortyList(
      Params params) {
    // TODO: implement getFilteredRickAndMortyList
    throw UnimplementedError();
  }
}
