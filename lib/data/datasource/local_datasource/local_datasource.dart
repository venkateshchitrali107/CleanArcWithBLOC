import 'package:flutter/foundation.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../model/rick_and_morty_model.dart';
import 'db.dart';

abstract class LocalDatasource {
  Future<List<RickAndMortyModel>> getRickAndMortyList(Params params);
}

class LocalDatasourceImpl implements LocalDatasource {
  final pageSize = 20;
  final MyDatabase db;
  LocalDatasourceImpl(this.db);
  @override
  Future<List<RickAndMortyModel>> getRickAndMortyList(Params params) async {
    try {
      List<RickAndMortyModelLocal> res = [];
      if (params.pageNumber == 0) {
        if (params.filterType.toLowerCase() == "name") {
          res = db.getFilteredName(params.searchKey.trim());
        } else if (params.filterType.toLowerCase() == "status") {
          res = db.getFilteredStatus(params.searchKey.trim());
        } else if (params.filterType.toLowerCase() == "species") {
          res = db.getFilteredSpecies(params.searchKey.trim());
        }
      } else {
        final offset = ((params.pageNumber - 1) * pageSize);
        res = db.getAll(pageSize, offset);
      }
      if (res.isNotEmpty) {
        List<RickAndMortyModel> currentRes = [];
        for (var rep in res) {
          currentRes.add(RickAndMortyModel.fromJson(rep.toJson()));
        }
        await Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
        return currentRes;
      }
      return [];
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw LocalCacheFailure();
    }
  }
}
