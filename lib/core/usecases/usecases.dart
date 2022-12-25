import '../error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Usecases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
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
