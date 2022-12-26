import 'package:equatable/equatable.dart';

abstract class RickAndMoryBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetInitialData extends RickAndMoryBlocEvent {}
