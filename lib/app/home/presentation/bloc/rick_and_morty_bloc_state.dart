import '../../domain/entity/rick_and_morty.dart';
import 'package:equatable/equatable.dart';

enum RickAndMoryBlocStatus { initial, success, failure }

class RickAndMoryBlocState extends Equatable {
  const RickAndMoryBlocState({
    this.status = RickAndMoryBlocStatus.initial,
    this.data = const <RickAndMorty>[],
    this.hasReachedMax = false,
  });

  final RickAndMoryBlocStatus status;
  final List<RickAndMorty> data;
  final bool hasReachedMax;

  RickAndMoryBlocState copyWith({
    RickAndMoryBlocStatus? status,
    List<RickAndMorty>? posts,
    bool? hasReachedMax,
  }) {
    return RickAndMoryBlocState(
      status: status ?? this.status,
      data: data,
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
