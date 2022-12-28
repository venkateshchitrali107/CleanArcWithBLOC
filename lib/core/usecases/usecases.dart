import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class Usecases<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

class Params extends Equatable {
  final int pageNumber;
  const Params({
    required this.pageNumber,
  });

  @override
  List<Object> get props => [pageNumber];
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
