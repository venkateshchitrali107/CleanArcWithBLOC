import 'app/home/data/datasource/remote_datasource.dart';
import 'app/home/domain/usecases/get_rick_and_morty_list.dart';
import 'app/home/presentation/bloc/rick_and_morty_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'app/home/data/reposistory/rick_and_morty_repo_impl.dart';
import 'app/home/domain/repository/rick_and_morty_repo.dart';

final GetIt serviceLocator = GetIt.instance;

void init() {
  try {
    serviceLocator.registerFactory(
      () => RemoteDatasourceImpl(),
    );
    serviceLocator.registerFactory(
      () => RickAndMortyRepositoryImpl(
        serviceLocator<RemoteDatasourceImpl>(),
      ),
    );
    serviceLocator.registerFactory(
      () => GetRickAndMortyList(
        serviceLocator<RickAndMortyRepositoryImpl>(),
      ),
    );
    serviceLocator.registerFactory(
      () => RickAndMortyBLOC(
        serviceLocator<GetRickAndMortyList>(),
      ),
    );
  } catch (e) {
    if (kDebugMode) print(e.toString());
  }
}
