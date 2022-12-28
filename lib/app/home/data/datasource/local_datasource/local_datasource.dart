import 'db.dart';
import '../../../../../core/error/failure.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../model/rick_and_morty_model.dart';

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
      final offset = ((params.pageNumber - 1) * pageSize);
      List<RickAndMortyModelLocalData> res = await db.getAll(pageSize, offset);
      if (res.isNotEmpty) {
        List<RickAndMortyModel> currentRes = [];
        for (var rep in res) {
          currentRes.add(RickAndMortyModel.fromJson(rep.toJson()));
        }
        await Future.delayed(const Duration(seconds: 3));
        return currentRes;
      }
      return [];
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw LocalCacheFailure();
    }
  }
}