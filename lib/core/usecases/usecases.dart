import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class Usecases<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

class Params extends Equatable {
  final int pageNumber;
  final String filterType;
  final String searchKey;
  const Params({
    required this.pageNumber,
    this.filterType = "",
    this.searchKey = "",
  });

  @override
  List<Object> get props => [
        pageNumber,
        filterType,
        searchKey,
      ];
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
