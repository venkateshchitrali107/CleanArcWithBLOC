import 'package:equatable/equatable.dart';

class RickAndMorty extends Equatable {
  final String id;
  final String name;
  final String status;
  final String species;
  const RickAndMorty({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
      ];
}
