import 'package:equatable/equatable.dart';

abstract class RickAndMortyBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RickAndMortyBlocEventInitialDataEvent extends RickAndMortyBlocEvent {}

class RickAndMortyBlocEventNextDataEvent extends RickAndMortyBlocEvent {}

class RickAndMortyBlocNetworkStatusUpdateEvent extends RickAndMortyBlocEvent {}

class RickAndMortyBlocFilterUpdateEvent extends RickAndMortyBlocEvent {}

class RickAndMortyBlocGetFilterDataEvent extends RickAndMortyBlocEvent {
  final String type;
  final String searchKey;
  RickAndMortyBlocGetFilterDataEvent({
    required this.searchKey,
    required this.type,
  });
}
