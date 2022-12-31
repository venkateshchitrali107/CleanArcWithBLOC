import '../../data/model/rick_and_morty_model.dart';

import 'package:equatable/equatable.dart';

enum RickAndMortyBlocStatus {
  initial,
  loading,
  success,
  failure,
  enableSearch,
  disableSearch
}

class RickAndMoryBlocState extends Equatable {
  const RickAndMoryBlocState({
    this.status = RickAndMortyBlocStatus.initial,
    this.data = const <RickAndMortyModel>[],
    this.hasReachedMax = false,
    this.enableSearch = false,
    this.searchedKey = "",
    this.filterKey = "Name",
  });

  final RickAndMortyBlocStatus status;
  final List<RickAndMortyModel> data;
  final bool hasReachedMax;
  final bool enableSearch;
  final String searchedKey;
  final String filterKey;

  RickAndMoryBlocState copyWith({
    RickAndMortyBlocStatus? status,
    List<RickAndMortyModel>? data,
    bool? hasReachedMax,
    bool? enableSearch,
    String? searchedKey,
    String? filterKey,
  }) {
    return RickAndMoryBlocState(
      status: status ?? this.status,
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      enableSearch: enableSearch ?? this.enableSearch,
      searchedKey: searchedKey ?? this.searchedKey,
      filterKey: filterKey ?? this.filterKey,
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
        enableSearch,
        searchedKey,
        filterKey,
      ];
}
