import 'app/home/data/datasource/local_datasource/db.dart';
import 'app/home/data/datasource/local_datasource/local_datasource.dart';
import 'core/network/network_info.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'app/home/data/datasource/remote_datasource/remote_datasource.dart';
import 'app/home/data/reposistory/rick_and_morty_repo_impl.dart';
import 'app/home/domain/usecases/get_rick_and_morty_list.dart';
import 'app/home/presentation/bloc/rick_and_morty_bloc.dart';

final GetIt serviceLocator = GetIt.instance;

void init() {
  try {
    serviceLocator.registerLazySingleton(
      () => NetworkInfoImpl()..checkForNetworkConnection(),
    );
    serviceLocator.registerLazySingleton(
      () => MyDatabase(),
    );
    serviceLocator.registerLazySingleton(
      () => RemoteDatasourceImpl(
        serviceLocator<MyDatabase>(),
      ),
    );
    serviceLocator.registerLazySingleton(
      () => LocalDatasourceImpl(
        serviceLocator<MyDatabase>(),
      ),
    );
    serviceLocator.registerLazySingleton(
      () => RickAndMortyRepositoryImpl(
        remoteDataSource: serviceLocator<RemoteDatasourceImpl>(),
        localDataSource: serviceLocator<LocalDatasourceImpl>(),
        networkInfo: serviceLocator<NetworkInfoImpl>(),
      ),
    );
    serviceLocator.registerLazySingleton(
      () => GetRickAndMortyList(
        serviceLocator<RickAndMortyRepositoryImpl>(),
      ),
    );
    serviceLocator.registerLazySingleton(
      () => RickAndMortyBLOC(
        listUseCase: serviceLocator<GetRickAndMortyList>(),
        networkInfo: serviceLocator<NetworkInfoImpl>(),
      ),
    );
  } catch (e) {
    if (kDebugMode) print(e.toString());
  }
}
