import '../../domain/entity/rick_and_morty.dart';
import 'package:equatable/equatable.dart';

enum RickAndMortyBlocStatus { initial, loading, success, failure }

class RickAndMoryBlocState extends Equatable {
  const RickAndMoryBlocState({
    this.status = RickAndMortyBlocStatus.initial,
    this.data = const <RickAndMorty>[],
    this.hasReachedMax = false,
  });

  final RickAndMortyBlocStatus status;
  final List<RickAndMorty> data;
  final bool hasReachedMax;

  RickAndMoryBlocState copyWith({
    RickAndMortyBlocStatus? status,
    List<RickAndMorty>? data,
    bool? hasReachedMax,
  }) {
    return RickAndMoryBlocState(
      status: status ?? this.status,
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''RickAndMoryBlocState { status: $status, hasReachedMax: $hasReachedMax, data: ${data.length} }''';
  }

  @override
  List<Object> get props => [
        status,
        data,
        hasReachedMax,
      ];
}
